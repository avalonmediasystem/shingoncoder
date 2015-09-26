require 'spec_helper'

describe Shingoncoder::Backend::TranscodeService do
  let(:job) { Shingoncoder::Backend::JobRegistry.create(outputs: [{}, {}]) }
  let(:id) { job.id }
  let(:service) { described_class.new(id) }

end
