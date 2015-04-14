require 'rails_helper'

RSpec.describe Article, type: :model do
  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  describe "will successfully save if" do
    after(:each) do
      expect(@article.save!).to eq(true)
    end
    
    it 'build from FactoryGirl' do
    end
  end
end
