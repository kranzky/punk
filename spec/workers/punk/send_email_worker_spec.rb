# frozen_string_literal: true

describe PUNK::SendEmailWorker do
  let(:from) { Faker::Internet.email }
  let(:to) { Faker::Internet.email }
  let(:title) { Faker::Name.name }
  let(:template) { Faker::Alphanumeric.alpha }

  before do
    require "mailgun-ruby"
    Mailgun::Client.deliveries.clear
  end

  it "is valid with valid attributes" do
    expect { described_class.perform_async(from: from, to: to, subject: title, template: template) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.not_to raise_error
  end

  it "is invalid without a from address" do
    expect { described_class.perform_async(to: to, subject: title, template: template) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "is invalid without a to address" do
    expect { described_class.perform_async(from: from, subject: title, template: template) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "is invalid without a subject" do
    expect { described_class.perform_async(from: from, to: to, template: template) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "is invalid without a template" do
    expect { described_class.perform_async(from: from, to: to, subject: title) }.to change(described_class.jobs, :size).by(1)
    expect { described_class.drain }.to raise_error(PUNK::BadRequest, "validation failed")
  end

  it "sends an email" do
    described_class.perform_async(from: from, to: to, subject: title, template: template)
    described_class.drain
    email = Mailgun::Client.deliveries.first
    expect(email[:from]).to eq(from)
    expect(email[:subject]).to eq(title)
  end
end
