# frozen_string_literal: true

describe PUNK::CreateIdentitiesService do
  before do
    create(:user, phone: nil)
    create(:user, email: nil)
  end

  it 'creates identities for users that are missing them' do
    expect(PUNK::Identity.count).to eq(0)
    described_class.run
    expect(PUNK::Identity.count).to eq(2)
  end
end
