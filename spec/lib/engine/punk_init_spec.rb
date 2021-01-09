# frozen_string_literal: true

describe PUNK do
  describe '.init' do
    it 'cannot be called twice' do
      expect { described_class.init }.to raise_error(PUNK::InternalServerError, "Cannot call PUNK.init multiple times!")
    end
  end
end
