require 'rails_helper'

describe Utils::TermsBuilder do

  describe '#make_terms' do
    let(:term_string) { 'test this, some thing' }
    let(:term_object) { 'term object' }

    it 'returns a list of tag objects' do
      expect(Term).to receive(:new).twice.and_return(term_object)
      expect(Utils::TermsBuilder.make_terms(term_string, 'tag'))
        .to eq([term_object, term_object])
    end

    it 'returns an empty array if no terms given' do
      [nil, '', '   ', '£@£$'].each do |trm|
        expect(Term).to_not receive(:new)
        expect(Utils::TermsBuilder.make_terms(trm, 'tag')).to eq([])
      end
    end

  end

  describe '#make_term' do

    it 'returns a new term for a given string' do
      term = Utils::TermsBuilder.make_term('some tag', 'tag')

      expect(term.name).to eq('some tag')
      expect(term.slug).to eq('some-tag')
      expect(term.term_group).to eq('tag')
    end

    it 'accepts valid term strings' do
      ['test', 'valid term, sss', '1 is good', 'Nikon 50mm F1.8D' ].each do |term_string|
        expect(Term).to receive(:new)
        Utils::TermsBuilder.make_term(term_string, 'tag')
      end

    end

    it 'raises exception if string is invalid' do
      ['', ' ', '#', nil, '-', '@', '^$£@%' ].each do |term_string|
      expect{ Utils::TermsBuilder.make_term(term_string, 'tag') }
        .to raise_error Errors::Term::InvalidName
      end

    end

    it 'raises exception if term_group is invalid' do
      expect{ Utils::TermsBuilder.make_term('some term', 'invalid-term') }
        .to raise_error Errors::Term::InvalidTermGroup
    end

    it 'returns existing term if not unique ' do
      some_tag = Term.new({
                            slug: 'some-tag',
                            name: 'some tag',
                            term_group: 'tag'
                          })
      some_tag.save!

      term = Utils::TermsBuilder.make_term('some tag', 'tag')

      expect(term).to eq(some_tag)
    end

  end

end
