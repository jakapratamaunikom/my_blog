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

  describe 'has method ' do
    context 'kind' do
      it 'wich will return origin if parent is blank' do
        @comment.parent = nil
        expect(@comment.kind).to eq(Comment::ORIGIN)
      end 

      it 'wich will return reply if parent is present' do
        @comment.parent = FactoryGirl.create(:comment)
        expect(@comment.kind).to eq(Comment::REPLY)
      end
    end

    context 'nested_comments' do
      before(:each) do
        @comment.save!
      end

      it 'return comment which parent equal current comment' do
        child_comment = FactoryGirl.create(:comment, parent: @comment)
        @comment.reload
        expect(@comment.nested_comments.to_a).to eq([child_comment])
      end
  
      it 'return comments which parent equal one of current comment child' do
        child_comment = FactoryGirl.create(:comment, parent: @comment)
        grand_child   = FactoryGirl.create(:comment, parent: child_comment)
        @comment.reload
        expect(@comment.nested_comments.to_a).to eq([child_comment, grand_child])
      end
      
      it 'return comments which parent equal one of current comment child. Thils grandchild comemnt must be after child comment' do
        child_comment = FactoryGirl.create(:comment, parent: @comment)
        another_child = FactoryGirl.create(:comment, parent: @comment)
        grand_child   = FactoryGirl.create(:comment, parent: child_comment)
        @comment.reload
        expect(@comment.nested_comments.to_a).to eq([child_comment, grand_child, another_child])
      end

    end
  end
end
