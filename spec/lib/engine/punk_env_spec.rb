# frozen_string_literal: true

describe PUNK do
  describe ".env" do
    it "loads environment" do
      expect(described_class.get.trace).to eq("spec_test")
    end

    it "loads configuration" do
      expect(described_class.env.to_sym).to eq(:test)
    end
  end
end
