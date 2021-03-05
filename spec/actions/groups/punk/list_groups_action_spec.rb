# frozen_string_literal: true

describe PUNK::ListGroupsAction do
  let(:user) { create(:user) }
  let(:tenant) { create(:tenant) }

  context "with no user provided" do
    it "returns a validation error" do
      view = described_class.run(tenant: tenant).result.render(:json)
      expect(view).to match("user is not present")
    end
  end

  context "with no tenant provided" do
    it "returns a validation error" do
      view = described_class.run(user: user).result.render(:json)
      expect(view).to match("tenant is not present")
    end
  end

  context "with valid arguments" do
    let(:groups) { create_list(:group, 3, tenant: tenant) }

    before do
      user.add_tenant(tenant)
      groups[0].add_user(user)
      groups[1].add_user(user)
    end

    it "returns groups for the tenant that the user is a member of" do
      expect(tenant.groups.count).to eq(3)
      view = JSON.parse(described_class.run(user: user, tenant: tenant).result.render(:json))
      expect(view.map { |h| h["id"] }.sort).to eq([groups[0].id, groups[1].id].sort)
    end
  end
end
