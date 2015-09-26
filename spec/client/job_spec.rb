require 'spec_helper'

describe Shingoncoder::Job do
  describe ".create" do
    before do
      Shingoncoder::Backend::JobRegistry::Job.create_table!
    end

    let(:file) { "file://#{File.absolute_path('spec/fixtures/Bars_512kb.mp4')}" }
    subject { Shingoncoder::Job.create(input: file) }
    it "returns a response" do
      expect_any_instance_of(Shingoncoder::Backend::TranscodeService).to receive(:transcode)
      expect(subject.code).to eq 201
      expect(subject.body['id']).to eq 1
    end
  end
end

