# frozen_string_literal: true

describe PUNK::Session do
  it "is valid with valid attributes" do
    expect { create(:session) }.not_to raise_error
  end

  it "is assigned a uuid on save" do
    session = build(:session)
    expect(session.id).to be_nil
    session.save
    expect(valid_uuid?(session.id)).to be(true)
  end

  it "can be saved with a custom uuid" do
    uuid = generate(:uuid)
    session = create(:session, id: uuid)
    expect(session.id).to eq(uuid)
  end

  it "must belong to an identity" do
    session = build(:session, identity: nil)
    expect(session.valid?).to be(false)
    expect(session.errors[:identity].first).to eq('is not present')
  end

  it "may have a user" do
    session = build(:session)
    expect(session.user).to exist
    session = build(:session, identity: create(:identity, user: nil))
    expect(session.user).to be_nil
  end

  it "can contain client data" do
    identity = create(:session, data: { foo: 'bar' })
    expect(identity.data[:foo]).to eq('bar')
  end

  it "permits only three validation attempts" do
    session = create(:session, attempt_count: 3)
    expect(session.valid?).to be(true)
    expect { session.increment_attempts }.to raise_error(Sequel::ValidationFailed, "attempt_count is not in range or set: [0, 1, 2, 3]")
  end

  it "starts in the created state" do
    session = create(:session)
    expect(session.created?).to be(true)
  end

  it "can be challenged" do
    session = create(:session)
    expect(session.may_challenge?).to be(true)
    session.challenge!
    expect(session.pending?).to be(true)
  end

  it "can be verified" do
    session = create(:session)
    session.challenge!
    expect(session.may_verify?).to be(true)
    session.verify!
    expect(session.active?).to be(true)
  end

  it "will not timeout when first created" do
    session = create(:session)
    session.timeout?
    expect(session.created?).to be(true)
  end

  it "will timeout after 5 minutes if not active" do
    session = create(:session)
    Timecop.travel(6.minutes.from_now)
    expect(described_class.expiring.count).to eq(1)
    session.timeout?
    expect(session.expired?).to be(true)
  end

  it "will not time out after 5 minutes if active" do
    session = create(:session, state: :active)
    Timecop.travel(1.week.from_now)
    expect(described_class.expiring.count).to eq(0)
    session.timeout?
    expect(session.active?).to be(true)
  end

  it "will timeout after 1 month if active but unused" do
    session = create(:session, state: :active)
    Timecop.travel((1.month + 1.day).from_now)
    expect(described_class.expiring.count).to eq(1)
    session.timeout?
    expect(session.expired?).to be(true)
  end

  it "will not timeout after 1 month if active and used" do
    session = create(:session, state: :active)
    Timecop.travel(6.months.from_now)
    session.touch
    session.timeout?
    expect(session.active?).to be(true)
  end

  it "will timeout after 1 year if active and used" do
    session = create(:session, state: :active)
    Timecop.travel((1.year + 1.day).from_now)
    session.touch
    session.timeout?
    expect(session.expired?).to be(true)
  end

  it "can be cleared" do
    session = create(:session, state: :active)
    expect(session.may_clear?).to be(true)
    session.clear!
    expect(session.deleted?).to be(true)
  end

  context "when many sessions exist" do
    before do
      create(:session, state: :created)
      create(:session, state: :pending)
      create(:session, state: :active)
      create(:session, state: :expired)
      create(:session, state: :deleted)
    end

    it "can be scoped to created sessions" do
      expect(described_class.count).to eq(5)
      expect(described_class.created.count).to eq(1)
    end

    it "can be scoped to pending sessions" do
      expect(described_class.count).to eq(5)
      expect(described_class.pending.count).to eq(1)
    end

    it "can be scoped to active sessions" do
      expect(described_class.count).to eq(5)
      expect(described_class.active.count).to eq(1)
    end

    it "can be scoped to expired sessions" do
      expect(described_class.count).to eq(5)
      expect(described_class.expired.count).to eq(1)
    end

    it "can be scoped to deleted sessions" do
      expect(described_class.count).to eq(5)
      expect(described_class.deleted.count).to eq(1)
    end

    it "can be accessed at random" do
      expect { described_class.sample }.not_to raise_error
    end
  end
end
