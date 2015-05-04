require 'rails_helper'

RSpec.describe Tag, type: :model do
  before(:each) do
    @tag = FactoryGirl.build(:tag)
  end

  it 'successful save if build from FactoryGirl' do
    expect(@tag.save!).to eq(true)
  end

  describe 'does not validate if' do
    after(:each) do
      expect(@tag.save).to eq(false)
    end

    it 'has blank title' do
      @tag.title = nil
    end

    it 'has blank lang' do
      @tag.lang  = nil
    end

    it 'has blank article' do
      @tag.article  = nil
    end
  end
end
