require 'rails_helper'

RSpec.describe Post, type: :model do

  it { should validate_presence_of(:content)}
  it { should validate_presence_of(:permalink)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:publish_date)}
  it { should validate_presence_of(:status)}

  it { should have_one(:thumbnail) }
  it { should have_and_belong_to_many(:terms) }
  it { should belong_to(:author) }

  it { should validate_uniqueness_of(:permalink) }
end
