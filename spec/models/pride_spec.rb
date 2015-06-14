require 'rails_helper'

RSpec.describe Pride, type: :model do
  before(:each) do
    @pride = FactoryGirl.create(:pride)
  end

  it 'successful save if bulid from FactoryGirl' do
    expect(@pride.save!).to eq(true)
  end

  it 'has method russian? which will return true if lang equal :ru' do
    @pride.lang = :ru
    expect(@pride.russian?).to eq(true)
  end
  it 'has method english? which will return true if lang equal :en' do
    @pride.lang = :en
    expect(@pride.english?).to eq(true)
  end
end
