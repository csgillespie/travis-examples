Example: Tests that require a working X-server
==============================================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=x-server)](https://travis-ci.org/csgillespie/travis-examples)


If your package tests require a virtual framebuffer, then add the following lines to `.travis.yml`

```yml
env:
  global:
    - DISPLAY=:99.0
install:
  - sh -e /etc/init.d/xvfb start
```

Alternatively, install the `xvfb-run` package and prefix the call with `xvfb-run` as shown in [this StackOverflow question](http://stackoverflow.com/questions/1710853/how-to-run-r-on-a-server-without-x11-and-avoid-broken-dependencies/).



