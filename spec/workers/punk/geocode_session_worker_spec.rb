# frozen_string_literal: true

describe PUNK::GeocodeSessionWorker, :vcr do
  let(:remote_addr) { "42.221.129.61" }
  let(:session) { create(:session, remote_addr: remote_addr) }

  it "updates the session data" do
    expect(session.data).to eq({})
    described_class.perform_async(session_id: session.id)
    described_class.drain
    session.reload
    expect(session.data).not_to eq({})
  end
end
