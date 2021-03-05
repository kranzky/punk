# frozen_string_literal: true

describe PUNK::ClearSessionAction do
  context "with no session provided" do
    it "returns a validation error" do
      view = described_class.run.result.render(:json)
      expect(view).to match("session is not present")
      expect(view).to match("session is empty")
    end
  end

  context "with an inactive session provided" do
    it "returns a validation error" do
      session = create(:session)
      view = described_class.run(session: session).result.render(:json)
      expect(view).to match("session is not in active state")
      expect(view).to match("session may not clear")
    end
  end

  context "with an active session provided" do
    it "clears the session" do
      session = create(:session, state: :active)
      view = described_class.run(session: session).result.render(:json)
      expect(view).to match("You have been logged out")
      expect(session.deleted?).to be(true)
    end
  end
end
