require 'rails_helper'

describe Image, type: :model do

  context 'validations' do
    it { should validate_presence_of(:url)}
    it { should validate_presence_of(:uploaded_time)}
    it { should validate_uniqueness_of(:url) }
  end

  context 'methods' do
    describe '#to_s' do
      let(:image) { Image.new({ url: 'test/this.jp', uploaded_time: '2015-08-13 18:11:21 UTC' }) }
      subject{ image.to_s }

      it 'returns a readable string representation of value' do
        expect(subject).to eq('url: test/this.jp, uploaded: 2015-08-13 18:11:21 UTC')
      end

    end

  end
end
