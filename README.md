# Minty

[![Build Status](https://travis-ci.org/mattdbridges/minty.svg?branch=master)](https://travis-ci.org/mattdbridges/minty)
[![Code Climate](https://codeclimate.com/github/mattdbridges/minty.png)](https://codeclimate.com/github/mattdbridges/minty)

Minty is the Unofficial Ruby API for Mint.com.

## Installation

Add this line to your application's Gemfile:

    gem 'minty'

And then execute:

    $ bundle

Right now, `minty` is not stable and is not on Rubygems, so you can clone it down locally to use it. Simply use `bin/minty` as the command instead of just `minty`.

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
