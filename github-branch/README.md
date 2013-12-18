Example: github branch
==========================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=travis-github-branch)](https://travis-ci.org/csgillespie/travis-examples)

The script illustrates installing a package from a github branch. The key line is:
```yml
  - ./travis-tool.sh install_github csgillespie/travis-examples@travis-basic
```
which installs the package from travis-basic branch of the csgillespie/travis-examples repo.