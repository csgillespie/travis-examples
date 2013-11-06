mrefun = function(t, z, model)
{
    s = model$get_stoic()
    haz = model$get_haz
    return(list(as.vector(s %*% haz(z))))
}

#' @title Calculates the deterministic solution of a stochastic kinetic model
#' @param model a skm object, created using the create_model function
#' @param maxtime the maximum simulation time
#' @param tstep the output grid size. Note this doesn't (really) affect the underlying ODE solver
#' @author Colin Gillespie
#' @return A matrix. The first column contains the simulation time, the other columns contain the species levels.
#' levels
#' @seealso create_model
#' @keywords character
#' @export
#' @examples demo(lv)
#' deterministic(model, 10, 0.1)
deterministic = function(model, maxtime, tstep)
{
    grid = seq(0, maxtime, tstep)	
    sol = ode(model$get_initial(), func=mrefun, times=grid, model)
    colnames(sol) = c("Time", rownames(model$get_stoic()))
    return(sol)
}

