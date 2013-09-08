require 'spec_helper'
require 'tmpdir'
require 'pathname'

class Minty::Credentials
  def self.reset!
    ENV["MINTY_EMAIL"] = nil
    ENV["MINTY_PASSWORD"] = nil
  end
end

describe Minty::Credentials do

  before do |example|
    Minty::Credentials.reset!
    Minty::Credentials.stub(:filename) { ".fakeminty" }
  end

  after do
    Minty::Credentials.clear!
  end

  it "should be able to clear the credentials" do
    credentials = Minty::Credentials.new('test', 'pass').save
    expect(credentials.email).to eq 'test'
    expect(credentials.password).to eq 'pass'
    Minty::Credentials.clear!
    credentials = Minty::Credentials.load
    expect(credentials.email).to eq ''
    expect(credentials.password).to eq ''
  end

  it "should be able to set credentails" do
    credentials = Minty::Credentials.load
    expect(credentials.email).to eq ''
    expect(credentials.password).to eq ''
    credentials.email = 'test'
    credentials.password = 'pass'
    credentials.save
    expect(credentials.email).to eq "test"
    expect(credentials.password).to eq "pass"
  end

  it "should be able to load credentials" do
    credentials = Minty::Credentials.new("test", "pass")
    credentials.save
    result = Minty::Credentials.load
    expect(result.email).to eq "test"
    expect(result.password).to eq "pass"
  end

  it "should be able to update credentials" do
    credentials = Minty::Credentials.new("test", "pass")
    credentials.save
    credentials.email = "test2"
    credentials.save
    result = Minty::Credentials.load
    expect(result.email).to eq "test2"
    expect(result.password).to eq "pass"
  end

  it "should respect inline assignment" do
    credentials = Minty::Credentials.new("test", "pass")
    credentials.save
    email, password = Minty::Credentials.load
    expect(email).to eq "test"
    expect(password).to eq "pass"
  end

  it "should respect the environment variables first" do
    ENV["MINTY_EMAIL"] = 'envtest'
    ENV["MINTY_PASSWORD"] = 'envpass'
    credentials = Minty::Credentials.load
    credentials.email = "test"
    credentials.password = "test"
    credentials.save
    expect(credentials.email).to eq "envtest"
    expect(credentials.password).to eq "envpass"
  end

  it "should know when it is setup" do
    credentials = Minty::Credentials.load
    credentials.email = "    "
    credentials.password = "    "
    credentials.save
    expect(credentials.setup?).to eq false

    credentials.email = "test"
    credentials.password = "pass"
    credentials.save
    expect(credentials.setup?).to eq true
  end

end
