# frozen_string_literal: true

describe PUNK::ListTenantUsersAction do
  context 'with no tenant provided' do
    it 'returns a validation error' do
      view = described_class.run.result.render(:json)
      expect(view).to match('tenant is not present')
    end
  end

  context 'with valid arguments' do
    let(:tenant) { create(:tenant) }
    let(:users) { create_list(:user, 3) }

    before do
      create_list(:user, 2)
      users.each { |user| tenant.add_user(user) }
    end

    it 'returns users that are members of the given tenant' do
      expect(PUNK::User.count).to eq(5)
      view = JSON.parse(described_class.run(tenant: tenant).result.render(:json))
      expect(view.map { |h| h['id'] }.sort).to eq(tenant.users.map(&:id).sort)
    end
  end
end
