require 'spec_helper'

describe Admin do
  
  let!(:admin) {create(:admin)}

  it "should have an email" do
    expect(admin.email).to_not be_nil
  end 

  it "should have a password" do
    expect(admin.encrypted_password).to_not be_nil
  end

end
