# frozen_string_literal: true

describe PUNK::VerifySessionAction do
  context 'with no session provided' do
    it 'returns a validation error' do
      view = described_class.run.result.render(:json)
      expect(view).to match('session is not present')
    end
  end

  context 'with no secret provided' do
    it 'returns a validation error' do
      session = create(:session)
      view = described_class.run(session: session).result.render(:json)
      expect(view).to match('secret is not present')
    end
  end

  context 'with an inactive session provided' do
    it 'returns a validation error' do
      session = create(:session)
      view = described_class.run(session: session, secret: 'xyzzy').result.render(:json)
      expect(view).to match('session is not in pending state')
      expect(view).to match('session may not verify')
    end
  end

  context 'with a pending session provided' do
    let(:session) { create(:session) }

    before do
      allow_any_instance_of(PUNK::SecretService).to receive(:process).and_return("xyzzy") # rubocop:disable RSpec/AnyInstance
      PUNK::ChallengeClaimService.run(session: session)
    end

    it 'returns an error if the secret is not correct' do
      expect { described_class.run(session: session, secret: 'qwerty') }.to raise_error(PUNK::BadRequest, "Secret is incorrect")
    end

    it 'expires the session after three failed attempts' do
      described_class.run(session: session, secret: 'qwerty') rescue nil # rubocop:disable Style/RescueModifier
      described_class.run(session: session, secret: 'qwerty') rescue nil # rubocop:disable Style/RescueModifier
      expect { described_class.run(session: session, secret: 'qwerty') }.to raise_error(PUNK::BadRequest, "Too many attempts")
    end

    it 'expires the session if it is more than five minutes old' do
      Timecop.travel(5.minutes.from_now)
      view = described_class.run(session: session, secret: 'xyzzy').result.render(:json)
      expect(view).to match('session may not verify')
      expect(session.expired?).to be(true)
    end

    it 'verifies the session if the secret is correct' do
      view = described_class.run(session: session, secret: 'xyzzy').result.render(:json)
      expect(view).to match('We have succesfully verified your identity')
      expect(session.active?).to be(true)
    end
  end
end
