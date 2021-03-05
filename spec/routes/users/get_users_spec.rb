# frozen_string_literal: true

describe PUNK, "GET /users" do
  include_context "Punk"

  context "when the user is not authenticated" do
    before do
      get "/users"
    end

    it { is_expected.not_to be_successful }
  end

  context "when the user is authenticated" do
    let(:tenant) { create(:tenant) }
    let(:identity) { create(:identity, claim_type: "phone") }
    let(:group) { create(:group, tenant: tenant) }
    let(:tenant_user) { create(:user) }
    let(:group_user) { create(:user) }

    before do
      identity.user.add_tenant(tenant)
      identity.user.add_group(group)
      tenant_user.add_tenant(tenant)
      group_user.add_tenant(tenant)
      group_user.add_group(group)
      login(identity.claim)
    end

    after do
      logout
    end

    context "without a group" do
      before do
        get "/users?tenant_id=#{tenant.id}"
      end

      it { is_expected.to be_successful }

      its(:body) do
        is_expected.to match(tenant_user.name)
        is_expected.to match(group_user.name)
      end
    end

    context "with a group" do
      before do
        get "/users?tenant_id=#{tenant.id}&group_id=#{group.id}"
      end

      it { is_expected.to be_successful }

      its(:body) do
        is_expected.not_to match(tenant_user.name)
        is_expected.to match(group_user.name)
      end
    end
  end
end
