# frozen_string_literal: true

module PUNK
  class BadRequest < StandardError; end
  class Unauthorized < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
  class Forbidden < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
  class NotFound < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
  class InternalServerError < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
  class NotImplemented < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
end
