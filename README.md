[![test](https://github.com/kranzky/punk/workflows/test/badge.svg)](https://github.com/kranzky/punk/actions?query=workflow%3Atest)
[![ship](https://github.com/kranzky/punk/workflows/ship/badge.svg)](https://github.com/kranzky/punk/actions?query=workflow%3Aship)
[![Gem Version](https://badge.fury.io/rb/punk.svg)](https://badge.fury.io/rb/punk)

# Punk!

Punk! is an omakase web framework for rapid prototyping.

## Release Process

1. `rake version:bump:whatever`
2. `rake gemspec:release BRANCH=main`
3. `rake git:release`
4. Create new release on GitHub to trigger ship workflow

## Copyright

Copyright (c) 2021 Jason Hutchens. See LICENSE for further details.
