require 'spec_helper'

describe Friend do
  
  let!(:friend) {create(:friend)}
  let(:occasion) {create(:occasion)}

  it "should have a first_name" do
    expect(friend.first_name).to_not be_nil
  end 

  it "should have a last_name" do
    expect(friend.last_name).to_not be_nil
  end

  it "should have an address" do
    expect(friend.street_address).to_not be_nil
    expect(friend.city).to_not be_nil
    expect(friend.state).to_not be_nil
    expect(friend.zipcode).to_not be_nil
  end

  it "should have no occasions on creation" do
    expect(friend.occasions.count).to be 0
  end

  it "should be able to add occasions" do
    create(:occasion)
    # expect{friend.occasions << occasion}.to change{friend.occasions.count}.from(0).to(1)
  end  

end