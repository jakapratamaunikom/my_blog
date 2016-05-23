require 'rails_helper'

RSpec.describe VAlexL::MyBlog::FormObjects::Note do

  before(:each) do
    @params = {:title => 'test_title', :description => 'description'}
    @invalid_params = {:title => nil, :description => nil}

    @note = FactoryGirl.build(:note)
    @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @params
  end

  describe 'has method valid?' do
    describe 'will return true and blank errors.full_messages if' do
      after(:each) do
        expect(@note_form.valid?).to eq(true)
        expect(@note_form.errors.full_messages.length).to eq(0)
      end

      it 'fills all params' do
        @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @params
      end  
    end
    
    it 'will return false and errors.full_messages will have information about blank title if title are blank' do
      @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @invalid_params
      expect(@note_form.valid?).to eq(false)
      expect(@note_form.errors.full_messages.length).to eq(2)
    end

    it 'will return false and errors.full_messages will be blank if title present but description blank' do
      @invalid_params[:title]   = 'Title'
      @invalid_params[:description] = ''
      @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @invalid_params

      expect(@note_form.valid?).to eq(false)
      expect(@note_form.errors.full_messages.length).to eq(1)
    end

    it 'will return false and errors.full_messages will be blank if description present but title blank' do
      @invalid_params[:title]   = ''
      @invalid_params[:description] = 'Description'
      @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @invalid_params

      expect(@note_form.valid?).to eq(false)
      expect(@note_form.errors.full_messages.length).to eq(1)
    end
  end

  describe 'has method save' do
    context "when create new" do
      describe "with valid params" do
        it 'return true' do
          expect(@note_form.save).to eq(true)
        end

        it 'create new record' do
          expect {@note_form.save}.to change(Note, :count).by(1)
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_params = {:title => nil, :description => nil}
          @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @invalid_params
        end

        it 'return false' do
          expect(@note_form.save).to eq(false)
        end

        it 'does not create new record' do
          expect {@note_form.save}.to change(Note, :count).by(0)
        end

        it 'return note with new attributes' do
          @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, @invalid_params
          expect(@note_form.save).to eq(false)
          expect(@note_form.title).to eq(@invalid_params[:title])
        end
      end
    end
  end
end
