[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
[![test](https://github.com/kranzky/punk/workflows/test/badge.svg)](https://github.com/kranzky/punk/actions?query=workflow%3Atest)
[![Coverage Status](https://coveralls.io/repos/github/kranzky/punk/badge.svg?branch=main)](https://coveralls.io/github/kranzky/punk?branch=main)
[![Gem Version](https://badge.fury.io/rb/punk.svg)](https://badge.fury.io/rb/punk)
[![Western Australia](https://corona.kranzky.com/oc/anz/au/wa/badge.svg)](https://corona.kranzky.com?region=oc&subregion=anz&country=au&state=wa)

# Punk!

Punk! is an omakase web framework for rapid prototyping.

## Release Process

1. `rake standard:fix`
2. `rake version:bump:whatever`
3. `rake gemspec:release BRANCH=main`
4. `rake git:release BRANCH=main`
5. Create new release on GitHub to trigger ship workflow

## Copyright

Copyright (c) 2021 Jason Hutchens. See LICENSE for further details.
