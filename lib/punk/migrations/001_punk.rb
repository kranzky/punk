# frozen_string_literal: true

def _tenants
  create_table :tenants do
    uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
    punk_state :state, null: false, default: 'created'
    String :name, null: false, text: true
    String :icon, text: true
    jsonb :data, default: '{}'
    DateTime :created_at
    DateTime :updated_at
  end
end

def _users
  create_table :users do
    uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
    punk_state :state, null: false, default: 'created'
    String :name, null: false, text: true
    String :icon, text: true
    String :email, text: true, unique: true
    String :phone, text: true, unique: true
    jsonb :data, default: '{}'
    DateTime :created_at
    DateTime :updated_at
  end
end

def _tenants_users
  create_table :tenants_users do
    primary_key [:tenant_id, :user_id]
    foreign_key :tenant_id, :tenants, null: false, type: :uuid
    foreign_key :user_id, :users, null: false, type: :uuid
    index [:tenant_id, :user_id]
  end
end

def _groups
  create_table :groups do
    uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
    punk_state :state, null: false, default: 'created'
    String :name, null: false, text: true
    String :icon, text: true
    jsonb :data, default: '{}'
    DateTime :created_at
    DateTime :updated_at
    foreign_key :tenant_id, :tenants, null: false, type: :uuid
  end
end

def _groups_users
  create_table :groups_users do
    primary_key [:group_id, :user_id]
    foreign_key :group_id, :groups, null: false, type: :uuid
    foreign_key :user_id, :users, null: false, type: :uuid
    index [:group_id, :user_id]
  end
end

def _identities
  create_enum(:claim_type, %w[email phone])
  create_table :identities do
    uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
    punk_state :state, null: false, default: 'created'
    claim_type :claim_type, null: false
    String :claim, text: true, null: false, unique: true
    jsonb :data, default: '{}'
    DateTime :created_at
    DateTime :updated_at
    foreign_key :user_id, :users, null: true, type: :uuid
  end
end

def _sessions
  create_enum(:session_state, %w[pending created active deleted expired])
  create_table :sessions do
    uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
    uuid :slug, default: Sequel.function(:gen_random_uuid)
    session_state :state, null: false, default: 'created'
    File :salt, text: true
    File :hash, text: true
    Integer :attempt_count, null: false, default: 0
    cidr :remote_addr, null: false, default: '127.0.0.1'
    String :user_agent, text: true, null: false, default: 'Mozilla/5.0 (compatible; Punk!; +https://punk.kranzky.com)'
    jsonb :data, default: '{}'
    DateTime :created_at
    DateTime :updated_at
    foreign_key :identity_id, :identities, null: false, type: :uuid
  end
end

PUNK.migration do
  change do
    create_enum(:punk_state, %w[created active deleted])
    _tenants
    _users
    _tenants_users
    _groups
    _groups_users
    _identities
    _sessions
  end
end
