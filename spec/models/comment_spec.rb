require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = FactoryGirl.build(:comment)
  end

  it 'will successful save if build from FactoryGirl' do
  end

  describe 'will not save if' do
    after(:each) do
      expect(@comment.save).to eq(false)
    end

    it 'has blank name' do
      @comment.name = nil
    end

    it 'has blank content' do
      @comment.content = nil
    end

    it 'has blank article' do
      @comment.article = nil
    end
  end
end
