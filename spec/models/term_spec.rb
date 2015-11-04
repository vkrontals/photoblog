require 'rails_helper'

describe Term, type: :model do

  context 'validations' do
    it { should have_and_belong_to_many(:posts) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:term_group) }

    it { should validate_inclusion_of(:term_group).in_array(Term::VALID_TERMS) }

    it { should validate_uniqueness_of(:slug) }
  end

  context 'methods' do
    describe '#to_s' do
      let(:tag) { Utils::TermsBuilder.make_term('stuff', 'tag') }
      subject{ tag.to_s }

      it 'returns a readable string representation of values' do
        expect(subject).to eq('name: stuff, type: tag')
      end

    end

  end

end
