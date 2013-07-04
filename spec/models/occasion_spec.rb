require 'spec_helper'

describe Occasion do

  let(:occasion) {create(:occasion)}

  it "should have a date" do
    expect{occasion.date}.to_not be_nil
  end

end
