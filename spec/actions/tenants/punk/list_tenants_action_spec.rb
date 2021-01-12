# frozen_string_literal: true

describe PUNK::ListTenantsAction do
  context 'with no user provided' do
    it 'returns a validation error' do
      view = described_class.run.result.render(:json)
      expect(view).to match('user is not present')
    end
  end

  context 'with a user provided' do
    let(:user) { create(:user) }

    before do
      create_list(:tenant, 3)
      3.times { create(:tenant).add_user(user) }
    end

    it 'returns tenants that the user belongs to' do
      expect(PUNK::Tenant.count).to eq(6)
      view = JSON.parse(described_class.run(user: user).result.render(:json))
      expect(view.map { |h| h['id'] }.sort).to eq(user.tenants.map(&:id).sort)
    end
  end
end
