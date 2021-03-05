# frozen_string_literal: true

describe PUNK::TenantUserMetadata do
  it "is valid with valid attributes" do
    expect { create(:tenant_user_metadata) }.not_to raise_error
  end

  it "is invalid without a tenant" do
    tenant_user_metadata = build(:tenant_user_metadata, tenant: nil)
    expect(tenant_user_metadata.valid?).to be(false)
    expect(tenant_user_metadata.errors[:tenant].first).to eq("is not present")
  end

  it "is invalid without a user" do
    tenant_user_metadata = build(:tenant_user_metadata, user: nil)
    expect(tenant_user_metadata.valid?).to be(false)
    expect(tenant_user_metadata.errors[:user].first).to eq("is not present")
  end

  it "displays as the two IDs concatenated" do
    tenant_user_metadata = create(:tenant_user_metadata)
    expect(tenant_user_metadata.to_s).to include(tenant_user_metadata.tenant.id)
    expect(tenant_user_metadata.to_s).to include(tenant_user_metadata.user.id)
  end

  context "when a user and a tenant exist" do
    let(:user) { create(:user) }
    let(:tenant) { create(:tenant) }

    context "when a user is added to a tenant" do
      let(:tenant_user_metadata) do
        described_class[tenant: tenant, user: user]
      end

      before do
        tenant.add_user(user)
      end

      it "is created automatically" do
        expect(tenant_user_metadata).not_to be_nil
        expect(tenant.users).to include(user)
      end

      it "destroying it will remove the user from the tenant" do
        expect(tenant.users).to include(user)
        tenant_user_metadata.destroy
        tenant.reload
        expect(tenant.users).not_to include(user)
      end
    end

    context "when it is created" do
      it "adds a user to a tenant" do
        expect(tenant.users).not_to include(user)
        create(:tenant_user_metadata, tenant: tenant, user: user)
        tenant.reload
        expect(tenant.users).to include(user)
      end
    end
  end
end
