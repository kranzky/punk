# frozen_string_literal: true

describe PUNK, "GET /groups" do
  include_context "Punk"

  context 'when the user is not authenticated' do
    before do
      get '/groups'
    end

    it { is_expected.not_to be_successful }
  end

  context 'when the user is authenticated' do
    let(:tenant) { create(:tenant) }
    let(:identity) { create(:identity, claim_type: 'phone') }
    let(:group) { create(:group, tenant: tenant) }

    before do
      identity.user.add_tenant(tenant)
      identity.user.add_group(group)
      login(identity.claim)
      get "/groups?tenant_id=#{tenant.id}"
    end

    after do
      logout
    end

    it { is_expected.to be_successful }
    its(:body) { is_expected.to match(group.name) }
  end
end
