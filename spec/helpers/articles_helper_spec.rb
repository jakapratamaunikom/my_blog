require 'rails_helper'

RSpec.describe ArticlesHelper, :type => :helper do
  describe "#get_tags_for_cloud" do
    before(:all) do
      Tag.destroy_all
      @tag1 = FactoryGirl.create(:tag)
      @tag2 = FactoryGirl.create(:tag)
      @tag3 = FactoryGirl.create(:tag)
      @tag4 = FactoryGirl.create(:tag)
      
      @article_with_tag_1_and_tag_2 = FactoryGirl.create(:article)
      @article_with_tag_1_and_tag_2.russian_content.tag_ids = [@tag1.id, @tag2.id]
      @article_with_tag_1_and_tag_2.russian_content.set_published!

      @article_with_tag_3_and_tag_4 = FactoryGirl.create(:article)
      @article_with_tag_3_and_tag_4.russian_content.tag_ids = [@tag3.id]
      @article_with_tag_3_and_tag_4.russian_content.set_published!

      @article_with_tag_1 = FactoryGirl.create(:article)
      @article_with_tag_1.russian_content.tag_ids = [@tag1.id]
      @article_with_tag_1.russian_content.set_published!

      @article_with_tag_2 = FactoryGirl.create(:article)
      @article_with_tag_2.russian_content.tag_ids = [@tag2.id]
      @article_with_tag_2.russian_content.set_published!

      @article_with_tag_3 = FactoryGirl.create(:article)
      @article_with_tag_3.russian_content.tag_ids = [@tag3.id]
      @article_with_tag_3.russian_content.set_published!

      @article_with_tag_4 = FactoryGirl.create(:article)
      @article_with_tag_4.russian_content.tag_ids = [@tag4.id]
      @article_with_tag_4.russian_content.set_published!
    end

    it "will return all tags if session[:tag_ids] nil" do
      session[:tag_ids] = nil
      expect(helper.get_tags_for_cloud(:ru).count).to eq(4)
    end

    it 'will return tag1 and tag2 if was selected tag1 before' do
      session[:tag_ids] = [@tag1.id]
      expect(helper.get_tags_for_cloud(:ru).count).to eq(2)
    end

    it 'will not return unpublished article_contents tag' do
      @article_with_tag_1_and_tag_3_but_unpiblished_russian_content = FactoryGirl.create(:article)
      @article_with_tag_1_and_tag_3_but_unpiblished_russian_content.russian_content.tag_ids = [@tag1.id, @tag3.id]
      @article_with_tag_1_and_tag_3_but_unpiblished_russian_content.russian_content.set_unpublished!
      session[:tag_ids] = [@tag1.id]

      expect(helper.get_tags_for_cloud(:ru).to_a).to eq([@tag1, @tag2]) #without @tag3
    end

    it 'will not return tag for article_content another language' do
      @article_with_tag_1_and_tag_3_but_piblished_english_content = FactoryGirl.create(:article)
      @article_with_tag_1_and_tag_3_but_piblished_english_content.english_content.tag_ids = [@tag1.id, @tag3.id]
      @article_with_tag_1_and_tag_3_but_piblished_english_content.english_content.set_published!
      session[:tag_ids] = [@tag1.id]

      expect(helper.get_tags_for_cloud(:ru).to_a).to eq([@tag1, @tag2]) #without @tag3
    end

     it 'will return tag1 and tag2 even if another article tagging tag1 and tag3' do
      @article_with_tag_1_and_tag_3 = FactoryGirl.create(:article)
      @article_with_tag_1_and_tag_3.russian_content.tag_ids = [@tag1.id, @tag3.id]
      @article_with_tag_1_and_tag_3.russian_content.set_published!
      session[:tag_ids] = [@tag1.id, @tag2.id]

      expect(helper.get_tags_for_cloud(:ru).to_a).to eq([@tag1, @tag2]) #without @tag3
    end


  end
end
