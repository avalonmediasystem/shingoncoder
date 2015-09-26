require 'spec_helper'

describe Shingoncoder::Backend::JobRegistry do
  describe ".create" do
    before do
      Shingoncoder::Backend::JobRegistry.create_tables!
    end

    after do
      Shingoncoder::Backend::JobRegistry.drop_tables!
    end

    let(:file) { "file://#{File.absolute_path('spec/fixtures/Bars_512kb.mp4')}" }
    context "with no output values" do
      it "creates a job with one output" do
        expect { described_class.create(input: file) }.
          to change { Shingoncoder::Backend::JobRegistry::Job.count }.by(1).
          and change { Shingoncoder::Backend::JobRegistry::Output.count }.by(1)
      end
    end

    context "with output values" do
      let(:attributes) { { input: file,
                           output: [{ uri: 'file:///foo.mp4' },
                                    { uri: 'file:///bar.webm' }] } }
      it "creates a job with one output" do
        expect { described_class.create(attributes) }.
          to change { Shingoncoder::Backend::JobRegistry::Job.count }.by(1).
          and change { Shingoncoder::Backend::JobRegistry::Output.count }.by(1)
      end

      it "returns a job" do
        expect(described_class.create(attributes)).to be_kind_of Shingoncoder::Backend::JobRegistry::Job
      end
    end
  end
end


