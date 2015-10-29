require 'rails_helper'

describe Utils::ImagesBuilder do

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
    let(:thumbnail) { Utils::ImagesBuilder.make_image(thumbnail_hash) }

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

      expect(Utils::ImagesBuilder.make_image(thumbnail_hash)).to eq(thumbnail)
    end

    it 'returns a new image if image id is not given' do
      thumbnail_hash['id'] = nil

      expect(Image).to receive(:new)
      Utils::ImagesBuilder.make_image(thumbnail_hash)
    end

    it 'returns an existing image if image id is not given and image url already exists' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'

      thumb1 = Utils::ImagesBuilder.make_image(thumbnail_hash)
      thumb1.save!

      expect(Image).to_not receive(:new)
      Utils::ImagesBuilder.make_image(thumbnail_hash)
    end

    it 'returns a new image even if only url and uploaded_time are set' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'
      thumbnail_hash['uploaded_time'] = DateTime.new

      expect(Image).to receive(:new)
      Utils::ImagesBuilder.make_image(thumbnail_hash)
    end

    it 'raises exception if url is missing' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = nil
      thumbnail_hash['uploaded_time'] = DateTime.new

      expect(Image).to_not receive(:new)
      expect { Utils::ImagesBuilder.make_image(thumbnail_hash) }
        .to raise_exception Errors::Image::UrlMissing
    end

    it 'raises exception if uploaded_time is missing' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'
      thumbnail_hash['uploaded_time'] = nil

      expect(Image).to_not receive(:new)
      expect { Utils::ImagesBuilder.make_image(thumbnail_hash) }
        .to raise_exception Errors::Image::UpdatedTimeMissing
    end

    it 'raises exception if uploaded_time is invalid' do
      thumbnail_hash['id'] = nil
      thumbnail_hash['caption'] = nil
      thumbnail_hash['alt_txt'] = nil
      thumbnail_hash['url'] = 'http://some-url.jpg'
      thumbnail_hash['uploaded_time'] = 'some/crap-format'

      expect(Image).to_not receive(:new)
      expect { Utils::ImagesBuilder.make_image(thumbnail_hash) }
        .to raise_exception Errors::Image::InvalidDateTimeFormat
    end

  end

end
