# zhsrc-opinionated

Useful shell scripts and environment configurations

## How to use

The easiest way is to simply do:

```shell
cd && mkdir dotlou && cd dotlou && git clone https://github.com/dotLou/zshrc-opinionated.git && ln -s $HOME/dotLou/zshrc-opinionated/default.zshrc $HOME/.zshrc
```

### Custom plugins

This package doesn't include any plugins pre-installed. To install your own, It's best to link back to the default plugins folder:

```shell
ln -s $HOME/.oh-my-zsh/custom/plugins $HOME/dotlou/zshrc-opinionated/zsh_custom/plugins
```

#### nvm

The plugin in [zsh-nvm](https://github.com/lukechilds/zsh-nvm) is already referenced, all you need to do is download the plugin

```shell
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
```

## Loaded configurations and behaviours

- Automatic `nvm` version switching when you `cd` into a directory that has a `.nvmrc` file
- Some docker tools

## Notable tools that are loaded

### http ([httpie](https://httpie.org/))

This is a replacement for `curl` with syntax highlighting and smart defaults.

Example:

```shell
http https://jsonplaceholder.typicode.com/users
```

## Optional things to install

These things will be automatically enabled after they are installed and you `source ~/.zshrc` (when using `default.zshrc` as your `~/.zshrc` file).

```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
brew install kubectl
brew install kubernetes-helm
brew install azure-cli
```
