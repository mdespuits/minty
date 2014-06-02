require 'bundler/setup'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock

  c.filter_sensitive_data('<EMAIL>') { Minty::Credentials.load.email }
  c.filter_sensitive_data('<PASSWORD>') { Minty::Credentials.load.password }
end

lib_path = File.expand_path("../../lib/**/*.rb", __FILE__)
Dir[lib_path].each { |d| require d }
