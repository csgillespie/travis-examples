
#The Lokta-Volterra model
#A hazard function
h = function(x, pars) {
    hazs = numeric(length(pars))
    hazs[1] = pars[1]*x[1]
    hazs[2] = pars[2]*x[1]*x[2]
    hazs[3] = pars[3]*x[2]
    return(hazs)
}

##The Jacobian
f = get_f = function(x, pars)
{
    fmat = matrix(0, nrow=3, ncol=2)
    fmat[1,1] = pars[1]
    fmat[2,1] = pars[2]*x[2]
    fmat[2,2] = pars[2]*x[1]
    fmat[3,2] = pars[3]
    return(fmat)
}

#The stoichiometric matrix
smat = matrix(0,nrow=2,ncol=3)
smat[1,1] = 1
smat[1,2] = -1
smat[2,2] = 1
smat[2,3] = -1
rownames(smat) = c("Prey", "Predator")
#Build the model
initial = c(100, 100)
pars = c(0.5,0.0025,0.3)
model = create_model(smat, h, initial, pars, f)
model$get_initial()
model$get_stoic()
model$get_haz(c(100, 100))
model$get_jacobian(c(100, 100))
