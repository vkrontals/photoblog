module Utils
  module TermsBuilder

    def self.make_terms(term_string, term_type)
      term_array = term_string.split(',').map(&:strip)

      term_array.map do |term_element|
        make_term term_element, term_type
      end

    end

    def self.make_term(term_string, term_group)
      Term.find_by_slug(term_string.parameterize) ||
        Term.new({
                   name: term_string,
                   slug: term_string.parameterize,
                   term_group: term_group
                 })
    end

  end

end
