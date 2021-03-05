# frozen_string_literal: true

describe PUNK::ListGroupUsersAction do
  context "with no group provided" do
    it "returns a validation error" do
      view = described_class.run.result.render(:json)
      expect(view).to match("group is not present")
    end
  end

  context "with valid arguments" do
    let(:group) { create(:group) }
    let(:users) { create_list(:user, 3) }

    before do
      create_list(:user, 2)
      users.each { |user| group.add_user(user) }
    end

    it "returns users that are members of the given group" do
      expect(PUNK::User.count).to eq(5)
      view = JSON.parse(described_class.run(group: group).result.render(:json))
      expect(view.map { |h| h["id"] }.sort).to eq(group.users.map(&:id).sort)
    end
  end
end
