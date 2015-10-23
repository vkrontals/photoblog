require 'rails_helper'

RSpec.describe Term, type: :model do

  it { should have_and_belong_to_many(:posts) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:term_group) }

  it { should validate_inclusion_of(:term_group).in_array(Term::VALID_TERMS) }

  it { should validate_uniqueness_of(:slug) }
end
