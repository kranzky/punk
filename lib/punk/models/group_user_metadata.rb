# frozen_string_literal: true

module PUNK
  class GroupUserMetadata < PUNK::Model(:groups_users)
    many_to_one :group
    many_to_one :user

    def validate
      validates_presence :group
      validates_presence :user
      validates_parse_id :parse_id, allow_blank: true
    end

    def to_s
      "#{group_id}|#{user_id}"
    end
  end
end
