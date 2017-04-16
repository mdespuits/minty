require 'yaml'
require 'yaml/store'
require 'etc'
require 'pathname'
require 'fileutils'
require 'openssl'

module Minty
  class Credentials
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

    def self.load
      config = YAML.load_file file
      new(config['mint_email'], config['mint_password'], encrypted: true)
    rescue => e
      new('', '').save
    end

    def initialize(email, password, options = {})
      @email = email
      @password = options[:encrypted] ? decrypt(password) : password
    end

    attr_writer :email, :password

    def email
      ENV.fetch("MINTY_EMAIL", @email).strip
    end

    def password
      environment_password || @password
    end

    def environment_password
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
        store['mint_password'] = encrypt(password)
      }
      FileUtils.chmod(0600, self.class.file)
      self
    end

    def setup?
      [email, password].map(&:strip).none?(&:empty?)
    end

    private

    def self.default_key
      self.file.to_s
    end

    def cipher(mode, key, data)
      cipher = OpenSSL::Cipher::Cipher.new('bf-cbc').send(mode)
      cipher.key = Digest::SHA256.digest(key)
      cipher.update(data) << cipher.final
    end

    def encrypt(data, key = self.class.default_key)
      data.empty? ? '' : cipher(:encrypt, key, data)
    end

    def decrypt(text, key = self.class.default_key)
      text.empty? ? '' : cipher(:decrypt, key, text)
    end
  end
end
