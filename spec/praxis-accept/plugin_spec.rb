require 'spec_helper'

describe Praxis::Accept::Plugin do
  subject { described_class.instance }

  describe '#config_key' do
    it 'responds' do
      expect(subject.config_key).not_to(be_nil)
    end
  end
end