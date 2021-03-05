# frozen_string_literal: true

describe PUNK, "PATCH /sessions" do
  include_context "Punk"

  before do
    patch "/sessions"
  end

  it { is_expected.not_to be_successful }
end
