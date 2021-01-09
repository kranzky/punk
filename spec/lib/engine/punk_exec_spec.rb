# frozen_string_literal: true

describe PUNK do
  describe '.exec' do
    it 'starts the PUNK engine' do
      expect(described_class.store.state).to eq(:started)
    end
  end
end
