require 'yaml'
require 'yaml/store'
require 'etc'
require 'pathname'
require 'fileutils'

module Minty
  class Credentials

    def self.load
      config = YAML.load_file file
      new(config['mint_email'], config['mint_password'])
    rescue => e
      new('', '').save
    end

    def self.system_user
      Etc.getlogin
    end

    def self.file
      Pathname.new(Dir.home(system_user)) + filename
    end

    def self.filename
      ".minty"
    end

    def self.clear!
      FileUtils.touch file
      FileUtils.rm_r file
    end

    attr_writer :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def email
      ENV.fetch("MINTY_EMAIL", @email).strip
    end

    def password
      ENV.fetch("MINTY_PASSWORD", @password).strip
    end

    def to_a
      [email, password]
    end
    alias to_ary to_a

    def save
      store = YAML::Store.new self.class.file.to_s
      store.transaction {
        store['mint_email'] = email.strip
        store['mint_password'] = password.strip
      }
      self
    end

    def setup?
      [email, password].map(&:strip).none?(&:empty?)
    end

  end
end
