#' @title Runs the Euler-Maruyama approximation
#' @inheritParams deterministic
#' @param ddt the step size used in the Euler-Maruyama solver
#' @author Colin Gillespie
#' @return  A matrix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' diffusion(model, 10, 0.05)

diffusion = function(model, maxtime, ddt)
{
  N = 100000
  s = model$get_stoic()		
  N = maxtime/ddt + 1
  xmat = matrix(0, nrow=N, ncol=length(model$get_initial()))
  x = model$get_initial()
  xmat[1,] = x
  pars = model$get_pars()
  sdt = sqrt(ddt)
  get_haz = model$get_haz
  for (i in 2:N){
    z = rnorm(length(pars), 0, sdt)
    h = model$get_haz(x)
    x = x +
      s %*% h*ddt +
      s %*% diag(sqrt(h)) %*% z
    
    #Reflecting barrier
    x[x < 0] = xmat[i-1,][x<0]
    xmat[i,] = x
  }
  times = seq(0, maxtime, by=ddt)
  xmat = cbind(times, xmat)
  colnames(xmat) = c("Time", rownames(s))
  
  xmat[nrow(xmat), 1] = maxtime
  return(xmat)
}


