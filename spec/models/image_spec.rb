require 'rails_helper'


describe Image, type: :model, focus: true do
  #it { should allow_mass_assignment_of(:url, :uploaded_time, :alt_txt, :caption) }
  it { should validate_presence_of(:url, :uploaded_time)}
end
