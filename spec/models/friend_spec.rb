require 'spec_helper'

describe Friend do
  
  let!(:friend) {create(:friend)}
  let(:occasion) {create(:occasion)}

  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}

  it { should have_many(:occasions) }

  it "should have no occasions on creation" do
    expect(friend.occasions.count).to be 0
  end

  it { should belong_to(:user) }

end