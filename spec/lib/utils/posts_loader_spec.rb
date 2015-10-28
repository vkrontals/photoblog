require 'rails_helper'

describe Utils::PostsLoader  do

  let(:json) { File.read('lib/data/posts.json')}
  let(:posts_loader) { Utils::PostsLoader.new json }

  it { expect(posts_loader.posts.length).to eq(3) }

  describe '#postify' do

    it { expect(posts_loader.postify.first).to be_a(Post) }
    it 'saves posts to the database' do
      posts_loader.postify

      expect(Post.count).to eq(3)
    end

  end

  describe '#make_post' do
    let(:post_json) {<<here
{
  "content": "Nikon F100, Sigma 70-200mm f2.8 OS, Ilford HP5 400",
  "publish_date": "2015-08-13 18:11:21",
  "updated": "2015-08-21 15:58:26",
  "title": "Couple in the park",
  "excerpt": "",
  "status": "publish",
  "permalink": "couple-in-the-park",
  "comment_count": 0,
  "thumbnail": {
    "caption": "some-caption",
    "alt_txt": "some-text",
    "uploaded_time": "2015-08-21 15:58:26",
    "url": "2015/08/couple-in-the-park-nikon-f100.jpg"
  },
  "categories": "35mm",
  "tags": "Nikon F100, Sigma 70-200mm f2.8 OS, black and white, Ilford HP5 400"
}
here
}
    let(:post_hash) { JSON.parse post_json }
    let(:make_post) { Utils::PostsLoader.make_post(post_hash) }

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

  describe '#make_image' do
    let(:thumbnail_json) {<<here
{
  "id": "1",
  "caption": "some-caption",
  "alt_txt": "some-text",
  "uploaded_time": "2015-08-21 15:58:26",
  "url": "some/url.jpg"
}
here
}
    let(:thumbnail_hash) { JSON.parse thumbnail_json }
    let(:thumbnail) { Utils::PostsLoader.make_image(thumbnail_hash) }

    it 'returns a new image object' do
      expect(thumbnail).to be_a(Image)
      expect(thumbnail.caption).to eq('some-caption')
      expect(thumbnail.alt_txt).to eq('some-text')
      expect(thumbnail.uploaded_time).to eq('2015-08-21 15:58:26'.to_datetime)
      expect(thumbnail.url).to eq('some/url.jpg')
    end

    it 'returns existing image' do
      thumbnail.save!

      expect(Image).to receive(:where).and_return(Array(thumbnail))

      expect(Utils::PostsLoader.make_image(thumbnail_hash)).to eq(thumbnail)
    end

    it 'returns a new image if image id is not given' do
      thumbnail_hash['id'] = nil

      expect(Image).to receive(:new)
      Utils::PostsLoader.make_image(thumbnail_hash)
    end

    it 'returns an existing image if image id is not given and image url already exists' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'

      thumb1 = Utils::PostsLoader.make_image(thumbnail_hash)
      thumb1.save!

      expect(Image).to_not receive(:new)
      Utils::PostsLoader.make_image(thumbnail_hash)
    end

    it 'returns a new image even if only url and uploaded_time are set' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'
      thumbnail_hash['uploaded_time'] = DateTime.new

      expect(Image).to receive(:new)
      Utils::PostsLoader.make_image(thumbnail_hash)
    end

    it 'raises exception if url is missing' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = nil
      thumbnail_hash['uploaded_time'] = DateTime.new

      expect(Image).to_not receive(:new)
      expect { Utils::PostsLoader.make_image(thumbnail_hash) }.to raise_exception Errors::Image::UrlMissing
    end

    it 'raises exception if uploaded_time is missing' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'
      thumbnail_hash['uploaded_time'] = nil

      expect(Image).to_not receive(:new)
      expect { Utils::PostsLoader.make_image(thumbnail_hash) }.to raise_exception Errors::Image::UpdatedTimeMissing
    end

    it 'raises exception if uploaded_time is invalid' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'
      thumbnail_hash['uploaded_time'] = 'some/crap-format'

      expect(Image).to_not receive(:new)
      expect { Utils::PostsLoader.make_image(thumbnail_hash) }.to raise_exception Errors::Image::InvalidDateTimeFormat
    end

  end

  describe '#make_terms' do
    let(:term_string) { 'test this, some thing' }
    let(:term_object) { 'term object' }

    it 'returns a list of tag objects' do
      expect(Term).to receive(:new).twice.and_return(term_object)
      expect(Utils::PostsLoader.make_terms(term_string, 'tag')).to eq([term_object, term_object])
    end

  end

  describe '#make_term' do

    let(:term) { Utils::PostsLoader.make_term('some tag', 'tag') }

    it 'returns a term object for a given string' do
      expect(term.name).to eq('some tag')
      expect(term.slug).to eq('some-tag')
      expect(term.term_group).to eq('tag')
    end

    it 'does not create a new term if it exists' do
      some_tag = Term.new({
                            slug: 'some-tag',
                            name: 'some tag',
                            term_group: 'tag'
                          })
      some_tag.save!

      expect(term).to eq(some_tag)
    end

  end

end
