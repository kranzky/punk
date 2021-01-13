# frozen_string_literal: true

describe PUNK, "DELETE /sessions" do
  include_context "Punk"

  before do
    delete '/sessions'
  end

  it { is_expected.not_to be_successful }
end
