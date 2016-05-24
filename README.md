# Itamae::Plugin::Resource::Brew

[Itamae](https://github.com/itamae-kitchen/itamae) resource plugin to manage packages with [homebrew](http://brew.sh/)/[linuxbrew](http://linuxbrew.sh/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-resource-brew'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-resource-brew

## Usage

```ruby
require "itamae/plugin/resource/brew"

# brew install git
brew 'git' do
  user 'user'
end

# Install with options like: brew install --with-lua --with-luajit vim
brew 'vim' do
  user 'user'
  options '--with-lua --with-luajit'
end
```

### with [itamae-plugin-recipe-linuxbrew](https://github.com/iyuuya/itamae-plugin-recipe-linuxbrew)

When using [itamae-plugin-recipe-linuxbrew](https://github.com/iyuuya/itamae-plugin-recipe-linuxbrew), user attribute set to `node[:linuxbrew][:user]` automatically

```yaml
# node.yml
linuxbrew:
  user: user
  packages:
    - git
    - gcc
...
```

```ruby
# recipe.rb
include_recipe "linuxbrew::install"

# auto-correct user to node[:linuxbrew][:user]
brew 'imagemagick' do
  options '--with-fontconfig --with-librsvg'
end
```

### Actions

- install
- uninstall

### Attributes

| Name    | Value                | Default                                 | Required |
|:--------|:---------------------|:----------------------------------------|:---------|
| action  | one of Symbol, Array | `:install`                              | Yes      |
| user    | String               | `node[:linuxbrew][:user]` (integration) | No       |
| cwd     | String               | (no default)                            | No       |
| name    | String               | (no default)                            | No       |
| options | String               | (no default)                            | No       |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iyuuya/itamae-plugin-resource-brew.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

