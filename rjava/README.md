Example: rJava dependency
===========================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=rjava)](https://travis-ci.org/csgillespie/travis-examples)

This branch illustrates loading the `rJava` package. The key lines are:

```yml
    language: java
    install:
        - sudo R CMD javareconf
```
