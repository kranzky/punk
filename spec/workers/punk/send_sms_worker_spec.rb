# frozen_string_literal: true

describe PUNK::SendSmsWorker do
  let(:to) { generate(:phone) }
  let(:body) { Faker::Lorem.sentence }

  before do
    PUNK.cache.delete(:plivo)
  end

  it "is valid with valid attributes" do
    expect { described_class.perform_async(to: to, body: body) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.not_to raise_error
  end

  it "is invalid without a to number" do
    expect { described_class.perform_async(body: body) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "is invalid without a message body" do
    expect { described_class.perform_async(to: to) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "sends an sms" do
    described_class.perform_async(to: to, body: body)
    described_class.drain
    sms = PUNK.cache.get(:plivo).first
    expect(sms[:from]).to eq(PUNK.get.plivo.number)
    expect(sms[:body]).to eq(body)
  end
end
