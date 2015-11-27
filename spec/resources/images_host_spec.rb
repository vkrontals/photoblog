require 'rails_helper'

describe Resources::ImagesHost do

  let(:images_host) { Resources::ImagesHost.new(:all, '') }

  describe '#images' do
    it 'returns the img value' do
      images_host.instance_variable_set(:@img, [1, 2, 3])
      expect(images_host).to receive(:external_images).and_return([1, 2, 3])

      expect(images_host.images).to eq([1, 2, 3])
    end

    it 'sets the img value if its not set' do

      expect(images_host).to receive(:external_images).and_return(['other value'])
      expect(images_host.images).to eq(['other value'])
    end

  end

end
