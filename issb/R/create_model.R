#' @title A mechanism for creating a stochastic kinetic model (skm)
#' @param stoic the stoichiometric of the skm model. The number of rows should equal the number
#' of species and the number of columns should equal the number of reactions.
#' @param hazards a function for calculating the reaction hazards.
#' @param initial a vector containing the initial conditions of the model.
#' @param pars a vector containing the parameter values.
#' @param jacobian only needed when simulating from the linear noise approximation.
#' @author Colin Gillespie
#' @return A list with class skm
#' @keywords character
#' @export
#' @examples demo(lv)

create_model = function(stoic, hazards, initial, pars, jacobian=NULL) {
    initial = initial
    pars = pars
    f = jacobian
    get_stoic = function() stoic
    get_haz = function(x, p=pars)  hazards(x, p)
    get_pars = function(p=pars)  {pars <<- p; pars}
    get_initial = function(i = initial) i
    get_jacobian = function(x, p=pars) jacobian(x, p)
    m = list(get_stoic = get_stoic, get_haz=get_haz, 
            get_pars=get_pars, get_initial=get_initial, 
            get_jacobian = get_jacobian)
    class(m) = "skm"
    return(m)
}


# summary.skm = function(m, ...) {
#     
# }