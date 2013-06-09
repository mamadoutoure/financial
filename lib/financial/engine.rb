module Financial
  class Engine < ::Rails::Engine
    isolate_namespace Financial
    require 'rubygems'
    require 'tabs_on_rails'
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
