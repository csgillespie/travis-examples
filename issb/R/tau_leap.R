#' Stochastic simulation using the diffusion tau leap algorithm
#' 
#' This simulates using the tau-leap algorithm in Gillespie, 2001.
#' You can turn off the estimate_midpoint (section VI of the paper) via the mid_point argument.
#' Typically, you don't want to do this.
#' @inheritParams deterministic
#' @param epsilon Default 0.03
#' @param mid_point  Logical (default TRUE). Should we use the mid_point method when updating species.
#' @return  A matrix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' tau_leap(model, 10)
tau_leap = function(model, maxtime, epsilon=0.03, mid_point=TRUE) {
    ##Shortcuts
    s = model$get_stoic()        
    pars = model$get_pars()
    get_haz = model$get_haz
    len_pars = length(pars)
    
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
        h = get_haz(x)
        h[h < 0] = 0
        ddt = min(epsilon*sum(get_haz(x))/denom)
        ddt = min(maxtime-time, ddt)
        if(is.nan(ddt)) ddt = maxtime-time
        
        if(mid_point) {
            x_dashed = as.vector(x + ddt*s %*% get_haz(x)/2)
        } else {
            x_dashed = x
        }
        
        h = get_haz(x_dashed)
        h[h < 0] = 0
        x = x + s %*% rpois(len_pars, h*ddt)
   
        x = as.vector(x)
        ## Reflecting barrier
        x[x < 0] = xmat[i-1, (1:length(x))+1L][x<0]
        time = time + ddt
        xmat[i,] = c(time, x)
    }
    xmat = xmat[1:i,]
    colnames(xmat) = c("Time", rownames(s))
    return(xmat)
}