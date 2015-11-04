require_relative "test_helper.rb"
require "test/unit"
require_relative "../src/ruby_json_test.rb"

class TestRubySDKHelloWorldApp < Test::Unit::TestCase

    def test_helloworldapp
        Ruby_json_App.new(ARGV)
    end

end
