require 'spec_helper'

describe User do
  
  let!(:user) {create(:user)}

  it "should have an email" do
    expect(user.email).to_not be_nil
  end 

  it "should have a password" do
    expect(user.encrypted_password).to_not be_nil
  end

  it "should have a first_name" do
    expect(user.first_name).to_not be_nil
  end 

  it "should have a last_name" do
    expect(user.last_name).to_not be_nil
  end

  it "should have an address" do
    expect(user.street_address).to_not be_nil
    expect(user.city).to_not be_nil
    expect(user.state).to_not be_nil
    expect(user.zipcode).to_not be_nil
  end

  it "should have no friends on creation" do
    expect(user.friends.count).to be 0
  end

  it "should be able to add friends" do
    expect{user.friends << create(:friend)}.to change{user.friends.count}.from(0).to(1)
  end  

end
