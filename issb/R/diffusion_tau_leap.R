#' Stochastic simulation using the diffusion tau leap algorithm
#' 
#' This simulates the standard diffusion/CLE approximation of the chemical 
#' master equation. However, the time steps are chosen according to the 
#' method suggested in Gillespie, 2001 tau-leap paper.
#' @inheritParams deterministic
#' @param epsilon Default 0.03
#' @param verbose Default FALSE
#' @return  A matrix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' gillespie(model, 10)


diffusion_tau_leap = function(model, maxtime, 
                              epsilon=0.03, verbose=FALSE) {
    ##Shortcuts
    s = model$get_stoic()    	
    pars = model$get_pars()
    get_haz = model$get_haz
    
    ## Initialise
    time = 0; i = 1   
    x = model$get_initial()
    xmat = matrix(0, nrow=100000, ncol=length(x)+1)
    xmat[i, ] = c(time, x)
    
    
    while(time < maxtime) {
        ## Update counter 
        i = i + 1
        
        ## Calculate time step
        xi = get_haz(x) %*% t(abs(s))
        denom = xi %*% t(model$get_jacobian(x))
        ddt = min(epsilon*sum(get_haz(x))/denom)
        ddt = min(maxtime-time, ddt)

        z = rnorm(length(pars), 0, sqrt(ddt))
        x_dashed = as.vector(x + ddt*s %*% get_haz(x)/2)
        
        h = get_haz(x_dashed)
        x = x +
            s %*% h*ddt +
            s %*% diag(sqrt(h)) %*% z
        x = as.vector(x)
        ## Reflecting barrier
        x[x < 0] = xmat[i-1, 2:length(x)][x<0]
        time = time + ddt
        xmat[i,] = c(time, x)
    }
    xmat = xmat[1:i,]
    colnames(xmat) = c("Time", rownames(s))
    return(xmat)
}