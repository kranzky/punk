# frozen_string_literal: true

describe PUNK, "POST /sessions" do
  include_context "Punk"

  before do
    post "/sessions"
  end

  it { is_expected.not_to be_successful }
end
