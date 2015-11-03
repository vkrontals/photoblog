require 'rails_helper'

describe Utils::PostsJsonGenerator do

  let(:post_json) { File.read('lib/data/single_post.json') }
  let(:post_hash) { JSON.parse post_json }

  let(:post) { Utils::PostsBuilder.make_post(post_hash) }

  describe '#generate' do
    subject { Utils::PostsJsonGenerator.generate(post) }

    it 'generates json for adding posts' do
      expect(subject).to eq(post_json)
    end

  end

  describe '#generate_terms' do
    context 'tags' do
      subject { Utils::PostsJsonGenerator.generate_terms(post, :tag) }

      it 'generates a tags string for a given post' do
        expect(subject).to eq('Nikon F100, Sigma 70-200mm f2.8 OS, black and white, Ilford HP5 400')
      end
    end

    context 'category' do
      subject { Utils::PostsJsonGenerator.generate_terms(post, :category) }

      it 'generates a category string for a given post' do
        expect(subject).to eq('35mm')
      end

    end

  end

end
