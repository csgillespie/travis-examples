compare_time = function(curr_l, curr_u, proposed) {
  equal_l = isTRUE(all.equal(as.numeric(curr_l), proposed))
  equal_l = equal_l || (curr_l < proposed)
  equal_u = isTRUE(all.equal(as.numeric(curr_u), proposed))
  equal_u = equal_u || (curr_u > proposed)
  return(equal_l && equal_u)
}

#' @title Discretises simulator output
#' @param sim_output a dataframe/matrix containing simulator output. The first column should be the simulation 
#' time
#' @param tstep output time step
#' @author Colin Gillespie
#' @return  A matrix with the same number of columns as output, discretised at time points: 0, 
#' tstep, 2tstep, ...
#' @keywords character
#' @export
#' @examples 
#' sim_output = data.frame(time = c(0, sort(runif(9))),  y=rpois(10, 2))
#' discretise(sim_output, 0.1)
discretise = function(sim_output, tstep) {
  time = tstep
  dd_dis = matrix(0, 
                  ncol=ncol(sim_output), 
                  nrow=(ceiling(max(sim_output[,1])/tstep)+1))
  colnames(dd_dis) = colnames(sim_output)
  dd_dis[1,] = as.numeric(sim_output[1,])
  
  nr = nrow(sim_output); nc = ncol(sim_output)
  j = 2
  for(i in 1:(nr-1)) {
    while(compare_time(sim_output[i, 1], sim_output[i+1, 1], time)) {
      dd_dis[j,] = c(time, sim_output[i, 2:nc])
      time = time + tstep
      j = j + 1
    }
  }
  return(dd_dis[1:(j-1), ])
}




