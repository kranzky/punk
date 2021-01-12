# frozen_string_literal: true

describe PUNK::ExpireSessionsWorker do
  before do
    create(:session, state: :pending)
    create(:session, state: :active)
  end

  it "does not expires new pending" do
    expect(PUNK::Session.count).to eq(2)
    described_class.perform_async
    described_class.drain
    expect(PUNK::Session.expired.count).to eq(0)
  end

  it "expires pending sessions after five minutes" do
    expect(PUNK::Session.pending.count).to eq(1)
    Timecop.travel(5.minutes.from_now)
    described_class.perform_async
    described_class.drain
    expect(PUNK::Session.pending.count).to eq(0)
  end

  it "expires unused active sessions after one month" do
    expect(PUNK::Session.active.count).to eq(1)
    Timecop.travel(32.days.from_now)
    described_class.perform_async
    described_class.drain
    expect(PUNK::Session.expired.count).to eq(2)
  end
end
