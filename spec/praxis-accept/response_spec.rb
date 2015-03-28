require 'spec_helper'

describe Praxis::Accept::Response do
  describe '#encode!' do
    subject { StubResponse.new }

    it 'detours to perform content negotiation' do
      expect(subject).to receive(:encode_without_content_negotiation!)
      subject.encode!
    end
  end

  describe '#encode_with_content_negotiation!' do
    subject { StubResponse.new(body, content_type) }

    context 'given an unstructured response body' do
      let(:body) { 'nice body!' }
      let(:content_type) { 'text/plain' }

      it 'does nothing' do
        subject.encode_with_content_negotiation!
        expect(subject.body).to eq(body)
        expect(subject.content_type).to eq(content_type)
      end
    end

    context 'given a structured response body' do
      let(:body) { {description: 'My widget', color: 'red'} }
      let(:content_type) { Praxis::MediaTypeIdentifier.load('application/vnd.acme.widget') }

      context 'when request is nil (e.g. functional test)' do
        before do
          subject.request = nil
        end

        it 'uses JSON' do
          subject.encode_with_content_negotiation!
          expect(subject.content_type.to_s).to eq('application/vnd.acme.widget+json')
        end
      end

      context 'when a suitable handler is available' do
        before do
          subject.request.env['HTTP_ACCEPT'] = 'application/json'
        end

        it 'uses the handler' do
          subject.encode_with_content_negotiation!
          expect(subject.content_type.to_s).to eq('application/vnd.acme.widget+json')
        end
      end

      context 'when no handler is suitable' do
        before do
          subject.request.env['HTTP_ACCEPT'] = 'application/vnd.acme.widget+funky'
        end

        it 'uses JSON' do
          subject.encode_with_content_negotiation!
          expect(subject.content_type.to_s).to eq('application/vnd.acme.widget+json')
        end
      end
    end
  end
end