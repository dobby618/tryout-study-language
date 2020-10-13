# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TryoutStudyLanguage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja
    config.active_record.default_timezone = :local

    # Don't generate system test files.
    config.generators do |g|
      g.template_engine :haml
      g.jbuilder false
      g.assets false
      g.helper false
      g.integration_tool :rspec
      g.test_framework :rspec,
                       routing_specs: false,
                       view_specs: false
    end

    # チェックボックスとのときはレイアウトが崩れるのでエラーのクラスを付与させない
    config.action_view.field_error_proc = proc do |html_tag, instance|
      include ActionView::Helpers::TagHelper
      if instance.is_a?(ActionView::Helpers::Tags::CheckBox)
        tag.raw(html_tag)
      else
        tag.div(html_tag, class: 'field_with_errors')
      end
    end
  end
end
