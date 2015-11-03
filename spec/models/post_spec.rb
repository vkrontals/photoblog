require 'rails_helper'

describe Post, type: :model do

  context 'validation' do
    it { should validate_presence_of(:content)}
    it { should validate_presence_of(:permalink)}
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:publish_date)}
    it { should validate_presence_of(:status)}

    it { should have_one(:thumbnail) }
    it { should have_and_belong_to_many(:terms) }
    it { should belong_to(:author) }

    it { should validate_uniqueness_of(:permalink) }
  end

  context 'methods' do
    let(:post_json) { File.read('lib/data/single_post.json') }
    let(:post_hash) { JSON.parse post_json }

    let(:post) { Utils::PostsBuilder.make_post(post_hash) }

    describe '#to_json' do
      subject { post.to_json }

      it 'generates json for adding posts' do
        expect(subject).to eq(post_json)
      end

    end

  end

end

