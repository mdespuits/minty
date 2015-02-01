# Minty

[![Build Status](https://travis-ci.org/mattdbridges/minty.svg?branch=master)](https://travis-ci.org/mattdbridges/minty)
[![Code Climate](https://codeclimate.com/github/mattdbridges/minty.png)](https://codeclimate.com/github/mattdbridges/minty)

Minty is the Unofficial Ruby API for Mint.com.

## Installation

Currently, `minty` is not entirely stable and is unavailable on Rubygems. You can still clone it down locally and install it via `gem` or `bundler`. You may need to use `bin/minty` instead of just `minty` depending on your installation method and environment.

### Using gem

From the gem's working directory, run:

    $ gem install pkg/minty-*.gem

### Using bundler

Add this line to your application's Gemfile:

    gem 'minty', git: 'git://github.com/mattdbridges/minty.git'

Alternatively, you can include it from a local directory

    gem 'minty', path: './vendor/minty'

And then execute:

    $ bundle

## Usage

### On the Command Line

To see how to use `minty` on the command line, you can just run

    $ minty
    Usage: minty [subcommand] [options]

    Available subcommands are:

      login:        Save your Mint.com credentials for other actions
      refresh:      Refresh your Mint.com accounts
      accounts:     Display a table of your Mint.com accounts
      categories:   Display a table of your Mint.com categories
      goals:        Display your Mint.com goals
      transactions: Transactions recorded on Mint.com

    For more options on each subcommand, try:

      minty [subcommand] --help

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
