# frozen_string_literal: true

describe PUNK::IdentifySessionWorker, :vcr do
  let(:user_agent) { 'Mozilla/5.0 (Windows NT x.y; Win64; x64; rv:10.0) Gecko/20100101 Firefox/10.0' }
  let(:remote_addr) { '92.177.45.168' }
  let(:session) { create(:session, user_agent: user_agent, remote_addr: remote_addr) }

  it 'updates the session data' do
    expect(session.data).to eq({})
    described_class.perform_async(session_id: session.id)
    described_class.drain
    session.reload
    expect(session.data.to_h).not_to eq({})
  end
end
