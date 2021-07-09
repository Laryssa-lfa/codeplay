require 'rails_helper'

describe Student do
  it { should have_many(:enrollments) }
  it { should have_many(:courses) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
