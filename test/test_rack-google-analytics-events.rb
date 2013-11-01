require File.expand_path('../helper',__FILE__)

class TestRackGoogleAnalyticsEvents < Test::Unit::TestCase

  context "Asyncronous With Events" do
    context "default" do
      setup do
        events = [GoogleAnalytics::Event.new("Users", "Login", "Standard")]
        mock_app :async => true, :tracker => 'somebody', :events => events
      end

      should "show events" do
        get "/"

        assert_match %r{ga\('send', {\"hitType\":\"event\",\"eventCategory\":\"Users\",\"eventAction\":\"Login\",\"eventLabel\":\"Standard\"}\)}, last_response.body
      end
    end

    context "with a event value" do
      setup do
        events = [GoogleAnalytics::Event.new("Users", "Login", "Standard", 5)]
        mock_app :async => true, :tracker => 'somebody', :events => events
      end
      should "show events with values" do
        get "/"

        assert_match %r{ga\('send', {\"hitType\":\"event\",\"eventCategory\":\"Users\",\"eventAction\":\"Login\",\"eventLabel\":\"Standard\",\"eventValue\":5}\)}, last_response.body
      end
    end
  end

  # context "Asyncronous With Push" do
  #   context "default" do
  #     setup do
  #         events = [GoogleAnalytics::Push.new(["_addItem", "ID", "SKU"])]
  #         mock_app :async => true, :tracker => 'somebody', :events => events
  #     end
  #     should "show events" do
  #       get "/"

  #       assert_match %r{\_gaq\.push}, last_response.body
  #       assert_match %r{_addItem.*_trackPageview}m, last_response.body
  #       assert_match %r{ID}, last_response.body
  #       assert_match %r{SKU}, last_response.body
  #       assert_match %r{ga('send', )}, last_response.body
  #     end

  #   end
  # end

  # context "Asyncronous With Custom Vars" do
  #   context "default" do
  #     setup do
  #         custom_vars = [GoogleAnalytics::CustomVar.new(1, "Items Removed", "Yes", GoogleAnalytics::CustomVar::SESSION_LEVEL)]
  #         mock_app :async => true, :tracker => 'somebody', :custom_vars => custom_vars
  #     end
  #     should "show events" do
  #       get "/"

  #       # assert_match %r{\_gaq\.push}, last_response.body
  #       # assert_match %r{_setCustomVar.*_trackPageview}m, last_response.body
  #       # assert_match %r{Items Removed}, last_response.body
  #       # assert_match %r{Yes}, last_response.body
  #       assert_match %r{ga('set', 'Items removed', 'Yes')}, last_response.body
  #     end

  #   end
  # end

end
