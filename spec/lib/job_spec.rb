require 'spec_helper'

describe Shingoncoder::Job do
  describe ".create" do
    let(:file) { "file://#{File.absolute_path('spec/fixtures/Bars_512kb.mp4')}" }
    subject { Shingoncoder::Job.create(input: file) }
    it "returns a response" do
      expect(subject.code).to eq 201
      expect(subject.body['id']).to eq 1234
    end
  end
end
