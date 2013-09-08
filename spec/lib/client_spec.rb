require 'spec_helper'

describe Minty::Client do

  let(:credentials) { Minty::Credentials.load }
  let(:client) { Minty::Client.new(credentials) }

  it "should instantiate properly" do
    expect(client.agent).to be_a Minty::Agent
    expect(client.credentials).to be_a Minty::Credentials
  end

  describe "#accounts" do
    it "should return an array of accounts" do
      expect(client.accounts).to be_a Array
      expect(client.accounts.first).to be_a Minty::Objects::Account
    end
  end

end
