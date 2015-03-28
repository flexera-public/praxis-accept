require 'spec_helper'

describe Praxis::Accept::Request do
  subject { StubRequest.new(env) }

  describe '#acceptable_content_types' do
    context 'when Accept header is absent' do
      let(:env) { {} }

      it 'returns an empty array' do

      end
    end

    context 'when Accept header is present' do
      let(:env) { {'HTTP_ACCEPT' => 'application/xml, application/json'} }
      let(:acceptable) do
        [Praxis::MediaTypeIdentifier.load('application/xml'),
         Praxis::MediaTypeIdentifier.load('application/json')]
      end

      it 'returns an array of media type identifiers' do
        expect(subject.acceptable_content_types).to eq(acceptable)
      end
    end

    context 'when Accept header is malformed' do
      let(:env) { {'HTTP_ACCEPT' => 'nachos, tacos'} }
      let(:acceptable) do
        [Praxis::MediaTypeIdentifier.load('application/nachos'),
         Praxis::MediaTypeIdentifier.load('application/tacos')]
      end

      it 'returns an array of media type identifiers' do
        expect(subject.acceptable_content_types).to eq(acceptable)
      end
    end
  end
end
