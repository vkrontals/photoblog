require 'rails_helper'

describe Image, type: :model do

    it { should validate_presence_of(:url)}
    it { should validate_presence_of(:uploaded_time)}
    it { should validate_uniqueness_of(:url) }

end
