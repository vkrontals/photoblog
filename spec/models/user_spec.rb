require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:slug) }
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:display_name) }
  it { should validate_presence_of(:slug) }
end
