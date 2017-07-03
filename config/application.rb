require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application
    # 不要ファイルを生成しない
    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
    end
    # deviseの日本語化
    config.i18n.default_locale = :ja
  end
end
