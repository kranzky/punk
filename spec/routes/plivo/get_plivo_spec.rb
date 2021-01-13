# frozen_string_literal: true

describe PUNK, "GET /plivo" do
  include_context "Punk"

  before do
    get '/plivo.html'
  end

  it { is_expected.to be_successful }
end
