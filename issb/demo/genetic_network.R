## The SIR model
#A hazard function

h_gen = function(x, pars) {
    hazs = numeric(length(pars))
    hazs[1] = pars[1]
    hazs[2] = pars[2]
    hazs[3] = pars[3]*x[1]
    hazs[4] = pars[4]*x[2]
    hazs[5] = pars[5]*x[1]*x[2]
    return(hazs)
}

## The stoichiometric matrix
## Sps, Reaction00
smat_gen = matrix(0, nrow=2, ncol=5)
smat_gen[1, 1] = 1

smat_gen[2, 2] = 1

smat_gen[1, 3] = -1
smat_gen[2, 4] = -1

smat_gen[1, 5] = -1
smat_gen[2, 5] = 20
rownames(smat_gen) = c("X1", "X2")