lnafun = function(t, state, model)
{
    s = model$get_stoic()
    u = nrow(s)
    z0 = state[1:u]
    m0 = state[(u+1):(2*u)]
    V0 = matrix(state[(2*u+1):length(state)],ncol=u)
    Ft = model$get_jacobian(z0)
    h = model$get_haz(z0)
    z = s %*% h
    m = s %*% Ft %*% m0
    V = V0 %*% t(Ft) %*% t(s) + s %*% diag(h) %*% t(s) + s %*% Ft %*% V0
    return(list(c(z, m, as.vector(V))))
}

lnastep = function(model, z, m, ddt)
{
    u = length(z)
    state = c(z, m, rep(0, u^2))	
    sol = deSolve::ode(y=state, func=lnafun, times=c(0, ddt), parms=model)
    
    #Remove first column and get just give the final row
    sol = sol[nrow(sol), -1]
    z = sol[1:u]
    m = sol[(u+1):(2*u)]
    V = matrix(sol[-(1:(2*u))], ncol=u)
    return(list(z=z, m=m, V=V))
}

#' @title Stochastic simulation using the linear noise approximation
#' @inheritParams deterministic
#' @inheritParams diffusion
#' @param restart a logical value. The default value of FALSE runs the standard
#' linear noise approximation. A value of TRUE runs the algorithm of Fearnhead, Giagos, and
#' Sherlock, 2012.
#' @author Colin Gillespie
#' @return  A matrix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' lna(model, 10, 0.1)

lna = function(model, maxtime, ddt, restart=FALSE) 
{

    z = model$get_initial()
    N = maxtime/ddt + 1	
    xmat = matrix(0, nrow=N, ncol=length(z))
    xmat[1,] = z
    
    ##Initialise m and V
    m = z*0
    V = matrix(0, length(z), length(z))
    for (i in 2:N){
        lsol = lnastep(model, z, m, ddt)
        z = lsol[["z"]]
                
        #Reflecting barrier
        xmat[i,] = MASS::mvrnorm(1, z + lsol[["m"]], lsol[["V"]])
        neg = xmat[i,] < 0
        xmat[i,][neg] = xmat[i-1,][neg]
        
        ##Reinitialise
        m = xmat[i, ] - lsol[["z"]] #set m
        if(restart){z = xmat[i,]; m = lsol[["m"]]*0}
    }
    xmat = cbind(seq(0, maxtime, ddt), xmat)
    colnames(xmat) = c("Time", rownames(model$get_stoic()))
    return(xmat)
}
