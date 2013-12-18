r-travis examples
=================
  
  This repository contains example [r-travis](https://github.com/craigcitro/r-travis) set-ups. Each branch 
illustrates a different travis scenario.

* [Basic set-up](https://github.com/csgillespie/travis-examples/tree/basic)
* Package not in the [root directory](https://github.com/csgillespie/travis-examples/tree/basic-directory)
* Package that contains a [vignette](https://github.com/csgillespie/travis-examples/tree/vignette)
* [Multiple packages](https://github.com/csgillespie/travis-examples/tree/multiple-packages) in a single repository
* [XML dependency](https://github.com/csgillespie/travis-examples/tree/xml)
* [rJava dependency](https://github.com/csgillespie/travis-examples/tree/rjava)
* [RODBC dependency](https://github.com/csgillespie/travis-examples/tree/rodbc)
* [github dependency](https://github.com/csgillespie/travis-examples/tree/github)
* [github branch dependency](https://github.com/csgillespie/travis-examples/tree/github-branch)
* [Bioconductor example](https://github.com/csgillespie/travis-examples/tree/bioconductor)
* Working [x-server](https://github.com/csgillespie/travis-examples/tree/x-server)
* [Compiling](https://github.com/csgillespie/travis-examples/tree/knitr) (only) knitr documents, i.e. you are not building a package.
* Installing from [CTAN](https://github.com/csgillespie/travis-examples/tree/ctan)


#### Pull request for existing examples

To edit an existing example:

1. Clone the relevant branch
1. Submit pull request as usual

I will then use git subtree to merge the changes from the branch to master

#### Adding a new example

1. Clone an existing example that matches your example
1. Ensure that your branch passes travis-ci
1. Clone the master and copy your branch to a directory
1. Submit pull request













