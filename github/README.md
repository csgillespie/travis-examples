Example: Installing packages from github
========================================
[![Build Status](https://travis-ci.org/csgillespie/travis-examples.png?branch=github)](https://travis-ci.org/csgillespie/travis-examples)

This branch illustrates installing a package from github. The key line is in the `install` section:

```yml
    - ./travis-tool.sh github_package trinker/qdapDictionaries
```

This line installs the `qdapDictionaries` package from trinker's repository.
