# frozen_string_literal: true

describe PUNK do
  describe ".store" do
    it "acts like a dotted hash" do
      described_class.store["foo"] = "bar"
      expect(described_class.store.foo).to eq("bar")
    end
  end
end
