# frozen_string_literal: true

describe PUNK::GroupUserMetadata do
  it "is valid with valid attributes" do
    expect { create(:group_user_metadata) }.not_to raise_error
  end

  it "is invalid without a group" do
    group_user_metadata = build(:group_user_metadata, group: nil)
    expect(group_user_metadata.valid?).to be(false)
    expect(group_user_metadata.errors[:group].first).to eq("is not present")
  end

  it "is invalid without a user" do
    group_user_metadata = build(:group_user_metadata, user: nil)
    expect(group_user_metadata.valid?).to be(false)
    expect(group_user_metadata.errors[:user].first).to eq("is not present")
  end

  it "displays as the two IDs concatenated" do
    group_user_metadata = create(:group_user_metadata)
    expect(group_user_metadata.to_s).to include(group_user_metadata.group.id)
    expect(group_user_metadata.to_s).to include(group_user_metadata.user.id)
  end

  context "when a user and a group exist" do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    context "when a user is added to a group" do
      let(:group_user_metadata) do
        described_class[group: group, user: user]
      end

      before do
        group.add_user(user)
      end

      it "is created automatically" do
        expect(group_user_metadata).not_to be_nil
        expect(group.users).to include(user)
      end

      it "destroying it will remove the user from the group" do
        expect(group.users).to include(user)
        group_user_metadata.destroy
        group.reload
        expect(group.users).not_to include(user)
      end
    end

    context "when it is created" do
      it "adds a user to a group" do
        expect(group.users).not_to include(user)
        create(:group_user_metadata, group: group, user: user)
        group.reload
        expect(group.users).to include(user)
      end
    end
  end
end
