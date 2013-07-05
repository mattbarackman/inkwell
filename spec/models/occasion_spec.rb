require 'spec_helper'

describe Occasion do

  let(:occasion) {create(:occasion)}

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:date)}
  it {should have_many(:orders)}
  it {should belong_to(:friend)}

end
