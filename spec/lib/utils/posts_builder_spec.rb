require 'rails_helper'

describe Utils::PostsBuilder do

  let(:json) { File.read('lib/data/posts.json')}
  let(:posts_loader) { Utils::PostsBuilder.new json }

  it { expect(posts_loader.posts.length).to eq(3) }

  describe '#postify' do

    it { expect(posts_loader.postify.first).to be_a(Post) }
    it 'saves posts to the database' do
      posts_loader.postify

      expect(Post.count).to eq(3)
    end

  end

  describe '#make_post' do
    let(:post_json) { File.read('lib/data/single_post.json')}
    let(:post_hash) { JSON.parse post_json }
    let(:make_post) { Utils::PostsBuilder.make_post(post_hash) }

    it 'adds a given post' do
      expect(make_post).to be_a(Post)
      expect(make_post.terms.first).to be_a(Term)
      expect(make_post.terms.length).to eq(5)
      expect(make_post.permalink).to eq('couple-in-the-park')
      expect(make_post.thumbnail).to be_a(Image)
      expect(make_post.thumbnail.url).to eq('2015/08/couple-in-the-park-nikon-f100.jpg')
      expect(make_post.thumbnail.uploaded_time).to eq('2015-08-21 15:58:26')
    end

  end

end
