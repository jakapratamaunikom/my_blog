require 'rails_helper'

RSpec.describe Image, type: :model do
  before(:each) do
    @image = FactoryGirl.build(:image)
  end

  it 'will successful save if FactoryGirl build' do
    expect(@image.save!).to eq(true)
  end

end