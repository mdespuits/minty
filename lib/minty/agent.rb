require 'mechanize'

module Minty

  MINT_URL = "https://wwws.mint.com/"

  class Agent

    def initialize
      @mechanize = ::Mechanize.new do |a|
        a.ssl_version = 'SSLv3'
        a.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    def get(path, opts = [])
      @mechanize.get("#{MINT_URL}#{path}", opts)
    end

    def post(path, opts = {}, headers = {})
      @mechanize.post("#{MINT_URL}#{path}", opts, headers)
    end

    def submit(*args)
      @mechanize.submit *args
    end

  end
end
