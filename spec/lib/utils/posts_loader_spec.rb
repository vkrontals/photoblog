require 'rails_helper'

describe Utils::PostsLoader, focus: true do

  let(:json) { File.read('lib/data/posts.json')}

  let(:posts_loader) { Utils::PostsLoader.new json }

  it { expect(posts_loader.posts.length).to eq(77) }

  describe '#postify' do

    it { expect(posts_loader.postify.first).to be_a(Post) }

    it 'saves posts to the database' do
      posts_loader.postify

      expect(Post.count).to eq(77)
    end

  end


end
