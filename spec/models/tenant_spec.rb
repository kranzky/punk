# frozen_string_literal: true

describe PUNK::Tenant do
  it "is valid with valid attributes" do
    expect { create(:tenant) }.not_to raise_error
  end

  it "is assigned a uuid on save" do
    tenant = build(:tenant)
    expect(tenant.id).to be_nil
    tenant.save
    expect(valid_uuid?(tenant.id)).to be(true)
  end

  it "can be saved with a custom uuid" do
    uuid = generate(:uuid)
    tenant = create(:tenant, id: uuid)
    expect(tenant.id).to eq(uuid)
  end

  it "is invalid without a name" do
    tenant = build(:tenant, name: nil)
    expect(tenant.valid?).to be(false)
    expect(tenant.errors[:name].first).to eq('is not present')
  end

  it "is valid without an icon" do
    tenant = build(:tenant, icon: nil)
    expect(tenant.valid?).to be(true)
  end

  it "is invalid if the icon is not a URL" do
    tenant = build(:tenant, icon: Faker::Alphanumeric.alpha)
    expect(tenant.valid?).to be(false)
    expect(tenant.errors[:icon].first).to eq('is not a URL')
  end

  it "can have multiple users" do
    tenant = create(:tenant)
    expect(tenant.users.count).to eq(0)
    3.times { create(:user).add_tenant(tenant) }
    expect(tenant.users.count).to eq(3)
  end

  it "can have multiple groups" do
    tenant = create(:tenant)
    expect(tenant.groups.count).to eq(0)
    create_list(:group, 3, tenant: tenant)
    expect(tenant.groups.count).to eq(3)
  end
end
