# frozen_string_literal: true

module PUNK
  # @model
  # @property slug(required) [string] a unique identifier for the session while it is being challenged
  # @property message(required) [string] a message to be displayed to the user to let them know what to do
  class Session < PUNK::Model
    alias_method :to_s, :state

    many_to_one :identity
    one_through_one :user, join_table: :identities, left_key: :id, left_primary_key: :identity_id

    symbolize :state

    aasm :state do
      state :created, initial: true
      state :pending
      state :active
      state :expired
      state :deleted

      event :challenge do
        transitions from: :created, to: :pending, guard: :current?
      end

      event :verify, after: :erase do
        transitions from: :pending, to: :active, guard: :current?
      end

      event :timeout, after: :erase do
        transitions from: [:created, :pending, :active], to: :expired
      end

      event :clear, after: :erase do
        transitions from: :active, to: :deleted
      end
    end

    dataset_module do
      def created
        where(state: "created")
      end

      def pending
        where(state: "pending")
      end

      def active
        where(state: "active")
      end

      def expired
        where(state: "expired")
      end

      def deleted
        where(state: "deleted")
      end

      def expiring
        where { Sequel.&({state: ["created", "pending"]}, (created_at < 5.minutes.ago)) }.or { Sequel.&({state: "active"}, ((updated_at < 1.month.ago) | (created_at < 1.year.ago))) }
      end
    end

    def validate
      validates_presence :identity
      validates_includes [:created, :pending, :active, :expired, :deleted], :state
      validates_integer :attempt_count
      validates_includes [0, 1, 2, 3], :attempt_count
    end

    def current?
      !timeout?
    end

    def timeout?
      timeout! if (created? || pending?) && created_at < 5.minutes.ago || active? && (updated_at < 1.month.ago || created_at < 1.year.ago)
      expired?
    end

    def erase
      update(slug: nil, salt: nil, hash: nil)
    end

    def increment_attempts
      update(attempt_count: attempt_count + 1)
    end
  end
end
