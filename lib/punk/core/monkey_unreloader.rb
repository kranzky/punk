# frozen_string_literal: true

# fixes https://github.com/jeremyevans/rack-unreloader/issues/9
module Rack
  class Unreloader
    class Reloader
      private

      def all_classes
        rs = Set.new
        ::ObjectSpace.each_object(Module).each do |mod|
          rs << mod if !mod.to_s.empty? && monitored_module?(mod)
        end
        rs
      end
    end
  end
end
