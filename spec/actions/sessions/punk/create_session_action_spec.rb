# frozen_string_literal: true

describe PUNK::CreateSessionAction do
  let(:remote_addr) { Faker::Internet.ip_v4_address }
  let(:user_agent) { Faker::Internet.user_agent }

  context "with no claim provided" do
    it "returns a validation error" do
      view = described_class.run(remote_addr: remote_addr, user_agent: user_agent).result.render(:json)
      expect(view).to match("claim is not present")
    end
  end

  context "with an email claim provided" do
    it "created an identity and a session" do
      email = Faker::Internet.email
      view = described_class.run(claim: email, remote_addr: remote_addr, user_agent: user_agent).result.render(:json)
      session = PUNK::Session.find(slug: ActiveSupport::JSON.decode(view)["slug"])
      expect(session.identity.claim_type).to eq(:email)
      expect(session.identity.claim).to eq(email)
    end
  end

  context "with a phone claim provided" do
    it "created an identity and a session" do
      phone = generate(:phone)
      view = described_class.run(claim: phone, remote_addr: remote_addr, user_agent: user_agent).result.render(:json)
      session = PUNK::Session.find(slug: ActiveSupport::JSON.decode(view)["slug"])
      expect(session.identity.claim_type).to eq(:phone)
      expect(session.identity.claim).to eq(phone)
    end
  end
end
