require 'spec_helper'

describe User do
  
  let!(:user) {create(:user)}

  it { should validate_presence_of(:email)}
  # it { should validate_presence_of(:encrypted_password)}
  # it { should validate_presence_of(:first_name)}
  # it { should validate_presence_of(:last_name)}

  it { should have_many(:friends) }
  it { should have_many(:occasions) }
  it { should have_many(:orders) }

  it "should have no friends on creation" do
    expect(user.friends.count).to be 0
  end

end
