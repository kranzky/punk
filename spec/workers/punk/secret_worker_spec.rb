# frozen_string_literal: true

describe PUNK::SecretWorker do
  let(:name) { Faker::Alphanumeric.alpha }

  it "is valid with valid attributes" do
    expect { described_class.perform_async(name: name) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.not_to raise_error
  end

  it "is invalid without a name" do
    expect { described_class.perform_async }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "can be performed immediately" do
    expect { described_class.perform_now(name: name) }.not_to raise_error
    expect { described_class.perform_now }.to raise_error(PUNK::BadRequest, "validation failed")
  end
end
