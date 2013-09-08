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

    def get(path, opts = {})
      request(:get, path, opts)
    end

    def post(path, opts = {})
      request(:post, path, opts)
    end

    def submit(*args)
      @mechanize.submit *args
    end

    private

      def request(type, path, opts = {})
        @mechanize.send(type, "#{MINT_URL}#{path}", opts)
      end

  end
end
