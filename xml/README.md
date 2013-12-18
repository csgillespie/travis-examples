Example: XML dependencies
==========================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=xml)](https://travis-ci.org/csgillespie/travis-examples)

This branch illustrates having an `XML` dependency. The key line is in the `install` section:

```
    - ./travis-tool.sh aptget_install r-cran-xml 
```

This line installs the `XML` package from the ubuntu repository with all the necessary dependencies.
