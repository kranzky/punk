# frozen_string_literal: true

describe PUNK, "GET /tenants" do
  include_context "Punk"

  context "when the user is not authenticated" do
    before do
      get "/tenants"
    end

    it { is_expected.not_to be_successful }
  end

  context "when the user is authenticated" do
    let(:tenant) { create(:tenant) }
    let(:identity) { create(:identity, claim_type: "phone") }

    before do
      identity.user.add_tenant(tenant)
      login(identity.claim)
      get "/tenants"
    end

    after do
      logout
    end

    it { is_expected.to be_successful }
    its(:body) { is_expected.to match(tenant.name) }
  end
end
