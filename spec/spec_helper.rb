require 'bundler/setup'

lib_path = File.expand_path("../../lib/**/*.rb", __FILE__)
Dir[lib_path].each { |d| require d }
