require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:subscriptions) }
  it { should have_many(:teas).through(:subscriptions) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
end
