require 'spec_helper'

describe Admin do
  
  let!(:admin) {create(:admin)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:encrypted_password)}

end
