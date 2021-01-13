# frozen_string_literal: true

describe PUNK, "GET /swagger" do
  include_context "Punk"

  before do
    get '/swagger'
  end

  it { is_expected.to be_successful }
  its(:body) { is_expected.to match('"openapi": "3.0.0"') }
end
