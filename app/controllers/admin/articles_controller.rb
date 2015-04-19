class Admin::ArticlesController < Admin::BaseController
  add_tasty_breadcrumb 'Админка', :admin_root_path
  add_tasty_breadcrumb 'Статьи',  :admin_articles_path

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    add_tasty_breadcrumb @article.title(lang), admin_article_path(1)
  end

  def new
    add_tasty_breadcrumb 'Создание новой статьи', :new_admin_article_path
    @article = Article.new
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article
  end

  def create
    @article = Article.new
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, article_params

    respond_to do |format|
      if @article_form.save
        format.html { redirect_to [:admin, @article_form.article], notice: 'Создана очередная мега статья' }
        format.json { render :show, status: :created, location: @article_form.article }
      else
        add_tasty_breadcrumb 'Создание', :new_admin_article_path

        format.html { render :new }
        format.json { render json: @article_form.errors, status: :unprocessable_entity }
      end
    end    
  end

  def edit
    @article = Article.find(params[:id])
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article
    
    add_tasty_breadcrumb @article.title(lang), admin_article_path(1)
    add_tasty_breadcrumb 'Редактирование', edit_admin_article_path(1)
  end

  def update
    @article      = Article.find(params[:id])
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, article_params

    respond_to do |format|
      if @article_form.save
        format.html { redirect_to [:admin, @article_form.article], notice: 'Статья изменена! Теперь она стала еще круче!!' }
        format.json { render :show, status: :ok, location: @article_form.article }
      else
        add_tasty_breadcrumb @article_form.article.title(lang), admin_article_path(1)
        add_tasty_breadcrumb 'Редактирование', edit_admin_article_path(@article)

        format.html { render :edit }
        format.json { render json: @article_form.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_path, notice: 'Гавностатья удалена! Завязывай такие писать..' }
      format.json { head :no_content }
    end

  end

  private
    def article_params
      params.require(:article).permit(:title_ru, :content_ru, :image_ru,
                                      :title_en, :content_en, :image_en)
                                      
    end

end
