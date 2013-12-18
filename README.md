Example: Package with vignettes
===============================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=vignette)](https://travis-ci.org/csgillespie/travis-examples)

The package in this branch contains a vignette that is built using `knitr`. By default, r-travis doesn't build 
vignettes. To make travis build the vignettes, add the following lines to your `.travis.yml` file:

```yml
env:
   global:
     - R_BUILD_ARGS=" " 
     - R_CHECK_ARGS="--as-cran"
     - BOOTSTRAP_LATEX="1"
```
