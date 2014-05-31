require 'minty/objects/account'
require 'minty/objects/category'
require 'minty/objects/goal'
require 'minty/objects/transaction'

module Minty
  class Client

    class FailedLogin < StandardError; end

    attr_reader :agent, :credentials

    def initialize(credentials)
      @agent        = Agent.new
      @credentials  = credentials
      @token        = nil
    end

    ACCOUNT_REQUEST = [{
      'args' => {
        'types' => [
          "BANK",
          "CREDIT",
          "INVESTMENT",
          "LOAN",
          "MORTGAGE",
          "OTHER_PROPERTY",
          "REAL_ESTATE",
          "VEHICLE",
          "UNCLASSIFIED"
        ],
      },
      "service" => "MintAccountService",
      "task" => "getAccountsSortedByBalanceDescending",
      "id" => "com.rubygem.minty",
    }]

    def accounts
      login {
        response_body = agent.post("bundledServiceController.xevent", "token" => @token, "input" => ACCOUNT_REQUEST.to_json).body
        parsed_body = ::JSON.parse(response_body)
        accounts = parsed_body["response"]["com.rubygem.minty"].fetch("response") { [] }

        Minty::Objects::Account.build(accounts)
      }
    end

    def transactions(args)
      args = {:filterType => "cash", :offset => 0, :comparableType => 0,
        :queryNew => '', :task => 'transactions'}.merge args

      args[:startDate] = args[:startDate].strftime('%m/%d/%Y') if args[:startDate].is_a?(Date)
      args[:endDate] = args[:endDate].strftime('%m/%d/%Y') if args[:endDate].is_a?(Date)

      login {
        response_body = agent.get("app/getJsonData.xevent?#{URI.encode_www_form(args)}").body
        parsed_body = ::JSON.parse(response_body)
        transactions = parsed_body["set"][0]["data"]
        Minty::Objects::Transaction.build(transactions).values
      }
    end

    def categories
      login {
        response_body = agent.get("app/getJsonData.xevent?task=categories").body
        parsed_body = ::JSON.parse(response_body)
        categories = parsed_body["set"][0]["data"]
        Minty::Objects::Category.build(categories)
      }
    end

    def goals
      login {
        page = agent.get("app/getJsonData.xevent?task=goals&rnd=1378927170581").body
        result = Minty::Objects::Goal.build(page)
      }
    end

    def refresh
      login {
        agent.get("overview.event") # needs to see overview for whatever reason
        agent.post("refreshFILogins.xevent", "token" => @token)
        true
      }
    end

    def update(obj)
      raise TypeError unless obj.is_a? Transaction
      login {
        agent.post("/updateTransaction.xevent", obj.to_update.merge!("token" => @token),
                   {"Origin" => MINT_URL, "Referer" => "#{MINT_URL}/transaction.event"})
      }
    end
      
    private
      def login
        return yield if @token
        agent.post('getUserPod.xevent', :username => credentials.email)
        page = agent.post('loginUserSubmit.xevent', :username => credentials.email,
                          :password => credentials.password, :task => 'L',
                          :nextPage => '', :browser => 'Chrome', :browserVersion => 32,
                          :os => 'v')

        raise FailedLogin unless page.at('input').attributes["value"]
        #@token = ::JSON.parse(page.at('input').attributes["value"].value)['token']
        @token = page.at('input').attributes["value"].value['token']
        yield
      end

      def logout
        @token = nil
        agent.get('logout.event?task=explicit')
        true
      end

  end
end
