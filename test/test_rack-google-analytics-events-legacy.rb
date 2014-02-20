require File.expand_path('../helper',__FILE__)

class TestRackGoogleAnalyticsEventsLegacy < Test::Unit::TestCase

  context "Asyncronous With Events" do
    context "default" do
      setup do
          events = [GoogleAnalytics::Legacy::Event.new("Users", "Login", "Standard")]
          mock_app_legacy :async => true, :tracker => 'somebody', :events => events
      end
      should "show events" do
        get "/"

        assert_match %r{\_gaq\.push}, last_response.body
        assert_match %r{_trackEvent.*_trackPageview}m, last_response.body
        assert_match %r{Users}, last_response.body
        assert_match %r{Login}, last_response.body
        assert_match %r{Standard}, last_response.body
      end

    end
  end

  context "Asyncronous With Push" do
    context "default" do
      setup do
          events = [GoogleAnalytics::Legacy::Push.new(["_addItem", "ID", "SKU"])]
          mock_app_legacy :async => true, :tracker => 'somebody', :events => events
      end
      should "show events" do
        get "/"

        assert_match %r{\_gaq\.push}, last_response.body
        assert_match %r{_addItem.*_trackPageview}m, last_response.body
        assert_match %r{ID}, last_response.body
        assert_match %r{SKU}, last_response.body
      end

    end
  end

  context "Asyncronous With Custom Vars" do
    context "default" do
      setup do
          custom_vars = [GoogleAnalytics::Legacy::CustomVar.new(1, "Items Removed", "Yes", GoogleAnalytics::Legacy::CustomVar::SESSION_LEVEL)]
          mock_app_legacy :async => true, :tracker => 'somebody', :custom_vars => custom_vars
      end
      should "show events" do
        get "/"

        assert_match %r{\_gaq\.push}, last_response.body
        assert_match %r{_setCustomVar.*_trackPageview}m, last_response.body
        assert_match %r{Items Removed}, last_response.body
        assert_match %r{Yes}, last_response.body
      end

    end
  end

  context "Test Instance Methods" do
    context "default" do
      setup do
          custom_vars = [GoogleAnalytics::Legacy::CustomVar.new(1, "Items Removed", "Yes", GoogleAnalytics::Legacy::CustomVar::SESSION_LEVEL)]
          mock_app_legacy :async => true, :tracker => 'somebody', :custom_vars => custom_vars
      end
      should "show events" do
#        controller.set_ga_custom_var(GoogleAnalytics::Legacy::CustomVar.new(1, "Items Removed", "Yes", GoogleAnalytics::Legacy::CustomVar::SESSION_LEVEL))

        get "/"

        assert_match %r{\_gaq\.push}, last_response.body
        assert_match %r{_setCustomVar.*_trackPageview}m, last_response.body
        assert_match %r{Items Removed}, last_response.body
        assert_match %r{Yes}, last_response.body
      end

    end
  end


end
