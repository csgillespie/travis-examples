Example: Basic example
==========================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=travis-basic-directory)](https://travis-ci.org/csgillespie/travis-examples)

This set-up is almost identical to the
[basic](https://github.com/csgillespie/travis-examples/tree/travis-basic)
set-up, except the package lives in the directory `goodpackage`. In the
`.travis.yml` script, we add the line to change directory

```yml
before_install:
    - cd goodpackage #Your directory name
```

