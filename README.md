<div align="center">

# asdf-purescript [![Build](https://github.com/jrrom/asdf-purescript/actions/workflows/build.yml/badge.svg)](https://github.com/jrrom/asdf-purescript/actions/workflows/build.yml) [![Lint](https://github.com/jrrom/asdf-purescript/actions/workflows/lint.yml/badge.svg)](https://github.com/jrrom/asdf-purescript/actions/workflows/lint.yml)

[purescript](https://github.com/purescript/documentation) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- NodeJS

# Install

Plugin:

```shell
asdf plugin add purescript https://github.com/jrrom/asdf-purescript.git
```

purescript:

```shell
# Show all installable versions
asdf list-all purescript

# Install specific version
asdf install purescript latest

# Set a version globally (on your ~/.tool-versions file)
asdf global purescript latest

# Now purescript commands are available
purs --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/jrrom/asdf-purescript/graphs/contributors)!

# Thanks

Special thanks to [asdf](https://github.com/asdf-vm/asdf)

# License

See [LICENSE](LICENSE) © [jrrom](https://github.com/jrrom/)
