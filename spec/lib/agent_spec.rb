require 'spec_helper'

describe Minty::Agent do
  it "should hit the login page with a GET request" do
    Mechanize.any_instance.should_receive(:get).with "https://wwws.mint.com/login.event", {}
    agent = Minty::Agent.new
    page = agent.get("login.event")
  end

  it "should hit the login page with a GET request and options" do
    Mechanize.any_instance.should_receive(:get).with "https://wwws.mint.com/login.event", {"token" => 'abcd'}
    agent = Minty::Agent.new
    page = agent.get("login.event", "token" => "abcd")
  end

  it "should hit the login page with a POST request" do
    Mechanize.any_instance.should_receive(:post).with "https://wwws.mint.com/login.event", {}
    agent = Minty::Agent.new
    page = agent.post("login.event")
  end
end
