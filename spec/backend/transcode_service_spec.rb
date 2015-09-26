require 'spec_helper'

describe Shingoncoder::Backend::TranscodeService do
  before do
    Shingoncoder::Backend::JobRegistry.create_tables!
  end

  after do
    Shingoncoder::Backend::JobRegistry.drop_tables!
  end

  let(:file) { "file://#{File.absolute_path('spec/fixtures/Bars_512kb.mp4')}" }
  let(:job) { Shingoncoder::Backend::JobRegistry.create(input: file) }
  let(:id) { job.id }
  let(:service) { described_class.new(id) }
  it 'produces output' do
    expect(service).to receive(:execute).with("ffmpeg  -i \"#{File.absolute_path('spec/fixtures/Bars_512kb.mp4')}\" -s 320x240 -vcodec libx264 -acodec libfdk_aac -g 30 -b:v 345k -ac 2 -ab 96k -ar 44100 /Users/justin/workspace/shingoncoder/spec/fixtures/Bars_512kb.mp4.mp4")
    service.transcode
  end

end
