# frozen_string_literal: true

describe PUNK, "GET /sessions" do
  include_context "Punk"

  context "when the user is not authenticated" do
    before do
      get "/sessions"
    end

    it { is_expected.not_to be_successful }
  end

  context "when the user is authenticated" do
    let(:user) { create(:user) }
    let(:identity) { create(:identity, user: user, claim_type: "phone") }

    before do
      login(identity.claim)
      get "/sessions"
    end

    after do
      logout
    end

    it { is_expected.to be_successful }
    its(:body) { is_expected.to match(user.active_sessions.first.id) }
  end
end
