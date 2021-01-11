# frozen-string-literal: true

require 'uri'
require 'phony'

module PUNK
  module Plugins
    module Validation
      module InstanceMethods
        def validates_url(atts, opts={})
          default = { message: "is not a URL" }
          validatable_attributes(atts, default.merge(opts)) do |_name, value, message|
            message unless URI::DEFAULT_PARSER.make_regexp.match(value).to_a.compact.length > 2
          end
        end

        def validates_email(atts, opts={})
          default = { message: "is not an email address" }
          validatable_attributes(atts, default.merge(opts)) do |_name, value, message|
            message unless URI::MailTo::EMAIL_REGEXP.match(value)
          end
        end

        def validates_phone(atts, opts={})
          default = { message: "is not a phone number" }
          validatable_attributes(atts, default.merge(opts)) do |_name, value, message|
            message unless Phony.plausible?(value)
          end
        end

        def validates_state(name, state)
          errors.add(name, "is not in #{state} state") unless self[name].send("#{state}?")
        end

        def validates_event(name, event)
          errors.add(name, "may not #{event}") unless self[name].send("may_#{event}?")
        end
      end
    end
  end
end
