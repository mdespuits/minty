require 'minty/objects/account'
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

    def transactions
      login {
        response = agent.get("transactionDownload.event?").body
        Minty::Objects::Transaction.build response
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

    private

      def login
        return yield if @token
        page = agent.get('login.event')
        form = page.form_with(id: "form-login")
        form.username = credentials.email
        form.password = credentials.password
        page = agent.submit(form, form.buttons.first)

        raise FailedLogin unless page.at('input').attributes["value"]
        @token = ::JSON.parse(page.at('input').attributes["value"].value)['token']
        yield
      end

      def logout
        @token = nil
        agent.get('logout.event?task=explicit')
        true
      end

  end
end
