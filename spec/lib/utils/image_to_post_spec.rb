require 'rails_helper'

describe Utils::ImageToPost do

  let(:json) { File.read('lib/data/posts.json')}
  let(:image) {
      Image.new({
        url: '2015/08/couple-in-the-park-nikon-f100.jpg',
        uploaded_time: '2015-08-21 15:58:26 UTC'
      }) }

  describe '#make' do
       let(:tags) {
      Utils::TermsBuilder.make_terms('nikon f100', 'tag')
    }

    let(:categories) {
      Utils::TermsBuilder.make_terms('35mm', 'category')
    }

    let(:result) {
      {
        content: '<p>Couple in the park nikon f100</p>',
        # publish_date: '2015-08-13 18:11:21 UTC',
        updated_at: nil,
        title: 'Couple in the park nikon f100',
        excerpt: '',
        status: 'publish',
        permalink: 'couple-in-the-park-nikon-f100',
        comment_count: 0,
        thumbnail: image,
        terms: 'couple, in, the, park, nikon, f100, 35mm'
      }
    }
    subject { Utils::ImageToPost.make(image) }

    it 'makes a post from an image' do
      expect(subject).to be_a(Post)
      result.keys.each do |key|
        expect(subject.send(key).to_s).to eql(result[key].to_s)
      end
      expect(subject.thumbnail.alt_txt).to eq('Couple in the park nikon f100')
      expect(subject.thumbnail.caption).to eq('Couple in the park nikon f100')
    end

  end

  describe '#extract_terms_string' do
    subject { Utils::ImageToPost.extract_terms_string('2015/10/some-url-stuff.jpg') }

    it 'extracts terms from the image' do
      expect(subject).to eq(%w{ some url stuff })
    end
  end

  describe '#extract_terms_string' do
    subject { Utils::ImageToPost }

    it{ expect(subject.guess_category('some stuff nikon' )).to eq('35mm') }
    it{ expect(subject.guess_category('some stuff centon')).to eq('35mm') }
    it{ expect(subject.guess_category('some stuff minolta')).to eq('35mm') }
    it{ expect(subject.guess_category('some bronica stuff')).to eq('medium format') }
    it{ expect(subject.guess_category('some stuff')).to eq('uncategorized') }
  end

end
