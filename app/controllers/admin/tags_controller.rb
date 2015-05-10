class Admin::TagsController < Admin::BaseController
  add_tasty_breadcrumb 'Теги', :admin_tags_path

  def index
    @tags = Tag.all    
  end

  def show
    @tag = Tag.find(params[:id])
    add_tasty_breadcrumb @tag, admin_tag_path(@tag)
    
  end

  def edit
    @tag = Tag.find(params[:id])
    add_tasty_breadcrumb @tag, admin_tag_path(@tag)
    add_tasty_breadcrumb "Редактирование", :edit_admin_tag_path
  end

  def new
    add_tasty_breadcrumb "Создание", :edit_admin_tag_path
    @tag = Tag.new
  end

  def create
    @tag = Tag.new get_tag_params

    respond_to do |format|
      if @tag.save
        format.html { redirect_to admin_tags_path }
        format.json { render json: @tag}
      else
        add_tasty_breadcrumb "Создание", :edit_admin_tag_path
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes get_tag_params
        format.html { redirect_to admin_tags_path }
      else
        add_tasty_breadcrumb @tag, admin_tag_path(@tag)
        add_tasty_breadcrumb "Редактирование", :edit_admin_tag_path
        format.html { render :edit }
      end
    end
  end

  private
    def get_tag_params
      params.require(:tag).permit(:title, :lang, :article_id)
    end
end
