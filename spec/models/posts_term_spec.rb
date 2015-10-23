require 'rails_helper'

RSpec.describe PostsTerm, type: :model do

  it { should belong_to(:post) }
  it { should belong_to(:term) }
end
