require 'rails_helper'

RSpec.describe VAlexL::MyBlog::FormObjects::Pride do
  before(:all) do
    @first_article  = FactoryGirl.create(:article) and @first_article.russian_content.set_published!
    @second_article = FactoryGirl.create(:article) and @second_article.english_content.set_published!
    
    @first_work  = FactoryGirl.create(:work) and @first_work.russian_content.set_published!
    @second_work = FactoryGirl.create(:work) and @second_work.english_content.set_published!

    @attributes  = { 
                      ru: ["Article #{@first_article.id}",  "Work #{@first_work.id}"],
                      en: ["Article #{@second_article.id}", "Work #{@second_work.id}"]
                    }
  end
  
  before(:each) do
    @pride_form = VAlexL::MyBlog::FormObjects::Pride.new
  end

  describe 'has method apply' do
    it 'create 4 new Pride records by arguments' do
      expect{
        @pride_form.apply!(@attributes)
      }.to change(Pride, :count).by(4)
    end

    it 'does not change the total count of Pride if update' do
      expect{
        @pride_form.apply!(@attributes)
      }.to change(Pride, :count).by(4)

      @pride_form = VAlexL::MyBlog::FormObjects::Pride.new
      expect{
        @pride_form.apply!(@attributes)
      }.to change(Pride, :count).by(0)

    end
  end

  describe 'has private method create_prides_for_lang!' do
    it 'create prides for given language' do
      prides = @pride_form.send(:create_prides_for_lang!, :ru, @attributes[:ru])
      expect(prides.all?{|p| p.russian?}).to eq(true)
    end

    it 'create prides with link on suitable article/work' do
      prides = @pride_form.send(:create_prides_for_lang!, :ru, @attributes[:ru])
      expect(prides.count).to eq(2)
      expect(prides.first.objective).to  eq(@first_article)
      expect(prides.second.objective).to eq(@first_work)
    end
  end

  describe 'has method is_article_select?' do
    it 'will return true if exists Pride with given objective equal article' do
      pride = FactoryGirl.create(:pride, objective: @first_article)
      expect(pride.objective).to eq(@first_article)
      expect(@pride_form.is_article_select?(@first_article)).to eq(true)
    end

    it 'will return false if does not exist Pride with given objective equal article' do
      some_article = FactoryGirl.create(:article)
      expect(@pride_form.is_article_select?(some_article)).to eq(false)
    end
  end

  describe 'has method is_work_select?' do
    it 'will return true if exists Pride with given objective equal work' do
      FactoryGirl.create(:pride, objective: @first_work)
      expect(@pride_form.is_work_select?(@first_work)).to eq(true)
    end

    it 'will return false if does not exist Pride with given objective equal work' do
      some_work = FactoryGirl.create(:work)
      expect(@pride_form.is_work_select?(some_work)).to eq(false)
    end
  end

end