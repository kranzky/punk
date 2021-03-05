# frozen_string_literal: true

describe PUNK::ListSessionsAction do
  context "with no user provided" do
    it "returns a validation error" do
      view = described_class.run.result.render(:json)
      expect(view).to match("user is not present")
    end
  end

  context "with a user provided" do
    let(:user) { create(:user) }
    let(:identity) { create(:identity, user: user) }

    before do
      create_list(:session, 3, state: "active")
      create_list(:session, 3, state: "active", identity: identity)
    end

    it "returns active sessions that the user belongs to" do
      expect(PUNK::Session.count).to eq(6)
      view = JSON.parse(described_class.run(user: user).result.render(:json))
      expect(view.map { |h| h["id"] }.sort).to eq(user.active_sessions.map(&:id).sort)
    end
  end
end
