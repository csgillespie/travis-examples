simulate = function(i, model, maxtime,
                    tstep, simulator,  ...) {
    set.seed(i)    
    discretise(simulator(model, maxtime, ...), tstep)
}

#' @title Multiple stochastic simulation
#' @inheritParams deterministic
#' @param no_sims the number of stochastic simulations to perform
#' @param no_cores the number of CPU cores to utilise.
#' @param simulator the stochastic simulator that will be used.
#' @param ... additional parameters that will be passed to the simulator
#' @author Colin Gillespie
#' @return  A matrix. The first column contains the simulation time, the other columns contain the species.
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' multiple_sims(model, 5, 1, 4, 2, pleap, ddt=0.5)

multiple_sims = function(model, maxtime,
                         tstep, no_sims, no_cores, simulator, ...) {
    
    cl = makeCluster(no_cores)
    clusterEvalQ(cl, require(issb))
    l = parLapply(cl, 1:no_sims, simulate, model, maxtime, tstep, simulator, ...)
    stopCluster(cl)
    
    l = Reduce("rbind", l)
    times = unique(l[,1])
    m_sim = cbind(rep(1:no_sims, each=length(times)), l)
    colnames(m_sim) = c("sim_no", "Time", rownames(model$get_stoic()))
    return(m_sim)
}

