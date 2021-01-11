# frozen_string_literal: true

describe PUNK::User do
  it "is valid with valid attributes" do
    expect { create(:user) }.not_to raise_error
  end

  it "is assigned a uuid on save" do
    user = build(:user)
    expect(user.id).to be_nil
    user.save
    expect(valid_uuid?(user.id)).to be(true)
  end

  it "can be saved with a custom uuid" do
    uuid = generate(:uuid)
    user = create(:user, id: uuid)
    expect(user.id).to eq(uuid)
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)
    expect(user.valid?).to be(false)
    expect(user.errors[:name].first).to eq('is not present')
  end

  it "validates name presence in the database" do
    user = build(:user, name: nil)
    expect { user.save(validate: false) }.to raise_error(Sequel::NotNullConstraintViolation)
  end

  it "is valid without an icon" do
    user = build(:user, icon: nil)
    expect(user.valid?).to be(true)
  end

  it "is invalid if the icon is not a URL" do
    user = build(:user, icon: Faker::Alphanumeric.alpha)
    expect(user.valid?).to be(false)
    expect(user.errors[:icon].first).to eq('is not a URL')
  end

  it "is valid without an email" do
    user = build(:user, email: nil)
    expect(user.valid?).to be(true)
  end

  it "is invalid if the email is not an email address" do
    user = build(:user, email: Faker::Alphanumeric.alpha)
    expect(user.valid?).to be(false)
    expect(user.errors[:email].first).to eq('is not an email address')
  end

  it "has a unique email" do
    email = create(:user).email
    user = build(:user, email: email)
    expect(user.valid?).to be(false)
    expect(user.errors[:email].first).to eq('is already taken')
  end

  it "validates email uniqueness in the database" do
    email = create(:user).email
    user = build(:user, email: email)
    expect { user.save(validate: false) }.to raise_error(Sequel::UniqueConstraintViolation)
  end

  it "is valid without a phone" do
    user = build(:user, phone: nil)
    expect(user.valid?).to be(true)
  end

  it "is invalid if the phone is not a phone number" do
    user = build(:user, phone: Faker::Alphanumeric.alpha)
    expect(user.valid?).to be(false)
    expect(user.errors[:phone].first).to eq('is not a phone number')
  end

  it "has a unique phone" do
    phone = create(:user).phone
    user = build(:user, phone: phone)
    expect(user.valid?).to be(false)
    expect(user.errors[:phone].first).to eq('is already taken')
  end

  it "validates phone uniqueness in the database" do
    phone = create(:user).phone
    user = build(:user, phone: phone)
    expect { user.save(validate: false) }.to raise_error(Sequel::UniqueConstraintViolation)
  end

  it "is invalid without either an email or a phone" do
    user = build(:user, email: nil, phone: nil)
    user.valid?
    expect(user.errors[:email].first).to eq('is not present')
    expect(user.errors[:phone].first).to eq('is not present')
  end

  it "can belong to multiple tenants" do
    user = create(:user)
    expect(user.tenants.count).to eq(0)
    3.times { create(:tenant).add_user(user) }
    expect(user.tenants.count).to eq(3)
  end

  it "can belong to multiple groups" do
    user = create(:user)
    expect(user.groups.count).to eq(0)
    3.times { create(:group).add_user(user) }
    expect(user.groups.count).to eq(3)
  end

  it "can have many sessions"

  it "has an active sessions scope"
end
