Example: Bioconductor packages
==============================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=bioconductor)](https://travis-ci.org/csgillespie/travis-examples)

This branch illustrates a package with Bioconductor dependencies. The key lines are in the `install` section, where we `source` the biocLite script and install the required packages (in this example, we install the `Mfuzz` package)

```yml
install:
    - ./travis-tool.sh bioc_install Mfuzz
    - ./travis-tool.sh install_deps
```

