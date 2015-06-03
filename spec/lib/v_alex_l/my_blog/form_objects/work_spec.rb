require 'rails_helper'


RSpec.describe VAlexL::MyBlog::FormObjects::Work do

  before(:each) do
    @ru_content = FactoryGirl.build(:work_content)
    @en_content = FactoryGirl.build(:work_content)
    @first_image  = FactoryGirl.create(:image)
    @second_image = FactoryGirl.create(:image)
    @params = {
      :ru_title     => @ru_content.title,
      :ru_content   => @ru_content.content,
      :ru_image     => @ru_content.image,
      :ru_published => @ru_content.published,
      :en_title     => @en_content.title,
      :en_content   => @en_content.content,
      :en_image     => @en_content.image,
      :en_published => @en_content.published,
      :image_ids    => [@first_image.id, @second_image.id]
    }
    @invalid_params = @params.clone

    @work      = FactoryGirl.build(:work)
    @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @params
  end


  describe 'has method valid?' do
    describe 'will return true and blank errors.full_messages if' do
      after(:each) do
        expect(@work_form.valid?).to eq(true)
        expect(@work_form.errors.full_messages.length).to eq(0)
      end

      it 'fills all params' do
        @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @params
      end  

      it 'has ru_title and ru_content but en_title, en_content are blank' do
        @invalid_params[:en_title]   = nil
        @invalid_params[:en_content] = nil
        @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params

        expect(@invalid_params[:ru_title].present?).to eq(true)
        expect(@invalid_params[:en_title].present?).to eq(false)
        expect(@work_form.en_title.present?).to eq(false)
        expect(@work_form.ru_title.present?).to eq(true)
      end

      it 'has en_title and en_content and but ru_title, ru_content are blank' do
        @invalid_params[:ru_title]   = nil
        @invalid_params[:ru_content] = nil
        @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params
      end

    end
    
    it 'will return false and errors.full_messages will have information about blank title if en_title and ru_title are blank' do
      @invalid_params[:en_title] = nil
      @invalid_params[:ru_title] = nil
      @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params
      expect(@work_form.valid?).to eq(false)
      expect(@work_form.errors.full_messages.length).to eq(1)
      expect(@work_form.errors.full_messages.first.strip).to eq('Работа должна содержать заголовок хотя бы на одном языке')
    end


    it 'will return false and errors.full_messages will have information about blank content if ru_title present but ru_content, en_title and en_content blank' do
      @invalid_params[:ru_title]   = 'Title'
      @invalid_params[:ru_content] = ''
      @invalid_params[:en_title]   = ''
      @invalid_params[:en_content] = ''
      @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params

      expect(@work_form.valid?).to eq(false)
      expect(@work_form.errors.full_messages.length).to eq(1)
      expect(@work_form.errors.full_messages.first.strip).to eq('Описание (ru) не может быть пустым')
    end

    it 'will return false and errors.full_messages will have information about blank content if en_title present but en_content, ru_title and ru_content blank' do
      @invalid_params[:en_title]   = 'Title'
      @invalid_params[:en_content] = ''
      @invalid_params[:ru_title]   = ''
      @invalid_params[:ru_content] = ''
      @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params

      expect(@work_form.valid?).to eq(false)
      expect(@work_form.errors.full_messages.length).to eq(1)
      expect(@work_form.errors.full_messages.first.strip).to eq('Описание (en) не может быть пустым')
    end

  end

  describe 'has method save' do
    context "when create new" do
      describe "with valid params" do
        it 'return true' do
          expect(@work_form.save).to eq(true)
        end

        it 'create new record' do
          expect {
              @work_form.save
              }.to change(Work, :count).by(1)
        end

        it 'create new two WorkConten records' do
          expect {
              @work_form.save
              }.to change(WorkContent, :count).by(2)
        end

        it 'save all attributes' do
          @work_form.save
          @work.reload
          expect(@work.russian_content.title).to eq(@params[:ru_title])
          expect(@work.english_content.title).to eq(@params[:en_title])
          expect(@work.russian_content.content).to eq(@params[:ru_content])
          expect(@work.english_content.content).to eq(@params[:en_content])
          expect(@work.images.to_a).to eq([@first_image, @second_image])
        end
      end

      describe "with invalid params" do
        before(:each) do
          @invalid_params[:ru_title]   = ''
          @invalid_params[:ru_content] = ''
          @invalid_params[:en_title]   = ''
          @invalid_params[:en_content] = ''
          @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params
        end

        it 'return false' do
          expect(@work_form.save).to eq(false)
        end

        it 'does not create new record' do
          expect {
              @work_form.save
              }.to change(Work, :count).by(0)
        end

        it 'return work with new attributes' do
          @invalid_params[:ru_title] = 'Invalid params'
          @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params
          expect(@work_form.save).to eq(false)
          expect(@work_form.ru_title).to eq(@invalid_params[:ru_title])
        end

        it 'has access to images' do
          @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, @invalid_params
          expect(@work_form.save).to eq(false)
          expect(@work_form.images.to_a).to eq([@first_image, @second_image])
        end
      end
    end
  end


  describe 'has method' do
    it 'ru_title= wich save title for work_content with russian language' do
      @work_form.ru_title= 'Русский заголовок'
      expect(@work_form.work.russian_content.title).to eq('Русский заголовок')
    end

    it 'en_title= wich save title for work_content with english language' do
      @work_form.en_title = 'English title'
      expect(@work_form.work.english_content.title).to eq('English title')
    end

    it 'ru_content= wich save image for work_content with russian language' do
      @work_form.ru_content= 'Что-то умное на русском языке'
      expect(@work_form.work.russian_content.content).to eq('Что-то умное на русском языке')
    end

    it 'en_content= wich save image for work_content with english language' do
      @work_form.en_content = 'Что-то умное на русском языке'
      expect(@work_form.work.english_content.content).to eq('Что-то умное на русском языке')
    end

    it 'ru_image= wich save image for work_content with russian language' do
      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        @work_form.ru_image = f
      end
      filename = File.basename(@work_form.work.russian_content.image.file.file)
      expect(filename).to eq("img.jpeg")
    end
    
    it 'en_image= wich save image for work_content with english language' do
      File.open("#{::Rails.root}/spec/files/img.jpeg") do |f|
        @work_form.en_image = f
      end
      filename = File.basename(@work_form.work.english_content.image.file.file)
      expect(filename).to eq("img.jpeg")
    end

    it 'ru_published= wich save published for work_content with russian language' do
      @work_form.ru_published = true
      expect(@work_form.work.russian_content.published).to eq(true)
      @work_form.ru_published = false
      expect(@work_form.work.russian_content.published).to eq(false)
    end
    
    it 'en_published= wich save published for work_content with english language' do
      @work_form.en_published = true
      expect(@work_form.work.english_content.published).to eq(true)
      @work_form.en_published = false
      expect(@work_form.work.english_content.published).to eq(false)
    end

  end

end
