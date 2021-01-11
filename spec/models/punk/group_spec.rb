# frozen_string_literal: true

describe PUNK::Group do
  it "is valid with valid attributes" do
    expect { create(:group) }.not_to raise_error
  end

  it "is assigned a uuid on save" do
    group = build(:group)
    expect(group.id).to be_nil
    group.save
    expect(valid_uuid?(group.id)).to be(true)
  end

  it "can be saved with a custom uuid" do
    uuid = generate(:uuid)
    group = create(:group, id: uuid)
    expect(group.id).to eq(uuid)
  end

  it "is invalid without a name" do
    group = build(:group, name: nil)
    expect(group.valid?).to be(false)
    expect(group.errors[:name].first).to eq('is not present')
  end

  it "is valid without an icon" do
    group = build(:group, icon: nil)
    expect(group.valid?).to be(true)
  end

  it "is invalid if the icon is not a URL" do
    group = build(:group, icon: Faker::Alphanumeric.alpha)
    expect(group.valid?).to be(false)
    expect(group.errors[:icon].first).to eq('is not a URL')
  end

  it "must belong to a tenant" do
    group = build(:group, tenant: nil)
    expect(group.valid?).to be(false)
    expect(group.errors[:tenant].first).to eq('is not present')
  end

  it "can have multiple members" do
    group = create(:group)
    expect(group.users.count).to eq(0)
    3.times { create(:user).add_group(group) }
    expect(group.users.count).to eq(3)
  end
end
