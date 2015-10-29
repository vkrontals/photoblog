module Utils
  module TermsBuilder

    def self.make_terms(term_string, term_type)
      term_array = term_string.to_s.split(',').map(&:strip)
      term_array.map do |term_element|
        begin
          make_term term_element, term_type

        rescue Errors::Term::InvalidName
          # TODO: some error logging
        end

      end.compact

    end

    def self.make_term(term_string, term_group)
      raise Errors::Term::InvalidName if term_string.to_s.parameterize.blank?
      raise Errors::Term::InvalidTermGroup if Term::VALID_TERMS.exclude? term_group

      Term.find_by_slug(term_string.parameterize) ||
        Term.new({
                   name: term_string,
                   slug: term_string.parameterize,
                   term_group: term_group
                 })
    end

  end

end
