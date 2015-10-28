require 'rails_helper'

describe Utils::TermsBuilder do

  describe '#make_terms' do
    let(:term_string) { 'test this, some thing' }
    let(:term_object) { 'term object' }

    it 'returns a list of tag objects' do
      expect(Term).to receive(:new).twice.and_return(term_object)
      expect(Utils::TermsBuilder.make_terms(term_string, 'tag')).to eq([term_object, term_object])
    end

  end

  describe '#make_term' do

    let(:term) { Utils::TermsBuilder.make_term('some tag', 'tag') }

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
