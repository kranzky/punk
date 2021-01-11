# frozen_string_literal: true

describe PUNK::Identity do
  it 'is valid with valid attributes' do
    expect { create(:identity) }.not_to raise_error
  end

  it 'must claim an email or a phone' do
    identity = build(:identity, claim_type: 'zork', claim: 'xyzzy')
    expect(identity.valid?).to be(false)
    expect(identity.errors[:claim_type].first).to eq('is not in range or set: [:email, :phone]')
  end

  it 'is assigned a uuid on save' do
    identity = build(:identity)
    expect(identity.id).to be_nil
    identity.save
    expect(valid_uuid?(identity.id)).to be(true)
  end

  it 'can be saved with a custom uuid' do
    uuid = generate(:uuid)
    identity = create(:identity, id: uuid)
    expect(identity.id).to eq(uuid)
  end

  it 'may belong to a user' do
    identity_with_user = create(:identity)
    expect(identity_with_user.user).to exist
    identity_without_user = create(:identity, user: nil)
    expect(identity_without_user.user).to be_nil
  end

  it 'has an email? accessor' do
    identity_with_email = build(:identity, claim_type: 'email')
    expect(identity_with_email.email?).to be(true)
    identity_without_email = build(:identity, claim_type: 'phone')
    expect(identity_without_email.email?).to be(false)
  end

  it 'has a phone? accessor' do
    identity_with_phone = create(:identity, claim_type: 'phone')
    expect(identity_with_phone.phone?).to be(true)
    identity_without_phone = create(:identity, claim_type: 'email')
    expect(identity_without_phone.phone?).to be(false)
  end

  it 'has a unique claim' do
    identity = create(:identity)
    duplicate_identity = build(:identity, claim_type: identity.claim_type, claim: identity.claim)
    expect(duplicate_identity.valid?).to be(false)
    expect(duplicate_identity.errors[:claim].first).to eq('is already taken')
  end

  it 'can have multiple sessions' do
    identity = create(:identity)
    expect(identity.sessions.count).to eq(0)
    create_list(:session, 3, identity: identity)
    expect(identity.sessions.count).to eq(3)
  end
end
