require 'rails_helper'

describe Resources::ImagesHost do

  let(:images_host) { Resources::ImagesHost.new }

  describe '#images' do
    it 'returns the img value' do
      images_host.instance_variable_set(:@img, [1, 2, 3])

      expect(images_host.images).to eq([1, 2, 3])
    end

    it 'sets the img value if its not set' do

      expect(images_host).to receive(:pull_latest).and_return(['other value'])
      expect(images_host.images).to eq(['other value'])
    end

  end

  describe '#pull_latest' do
    let(:external_images_array) {
      [
        OpenStruct.new({ url: 'test/this1.jpg', last_modified: Date.today }),
        OpenStruct.new({ url: 'test/this2.jpg', last_modified: Date.today })
      ]
    }

    it 'returns a list of uploaded images' do
      expect(images_host).to receive(:external_images).and_return(external_images_array)

      pulled_images = images_host.pull_latest

      expect(pulled_images.length).to be(2)

      pulled_images.each do |img|
        expect(img).to be_a(Image)
      end

    end

    it 'requests images for the date given' do
      date = Date.parse('10-10-2015')
      expect(Date).to receive(:today).and_return(date)
      expect(images_host).to receive(:external_images).and_return([])
      images_host.pull_latest
    end

  end

end
