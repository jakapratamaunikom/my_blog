class Admin::ArticlesController < Admin::BaseController
  add_tasty_breadcrumb 'Статьи',  :admin_articles_path

  def index
    @search_article = VAlexL::MyBlog::Search::Article.new(params[:query_search])
    @articles = @search_article.search
    @articles = @articles.page(params[:page]).per(10).uniq
  end

  def show
    @article = Article.find(params[:id])
    add_tasty_breadcrumb @article.get_content(current_lang).title, admin_article_path(@article)
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
    
    add_tasty_breadcrumb @article.get_content(current_lang).title, admin_article_path(@article)
    add_tasty_breadcrumb 'Редактирование', edit_admin_article_path(@article)
  end

  def update
    @article      = Article.find(params[:id])
    @article_form = VAlexL::MyBlog::FormObjects::Article.new @article, article_params

    respond_to do |format|
      if @article_form.save
        format.html { redirect_to admin_article_path(@article_form.article, lang: current_lang), notice: 'Статья улучшена! Теперь она стала еще круче!!' }
        format.json { render :show, status: :ok, location: @article_form.article }
      else
        add_tasty_breadcrumb @article_form.article.get_content(current_lang).title, admin_article_path(@article)
        add_tasty_breadcrumb 'Редактирование', edit_admin_article_path(@article)

        format.html { render :edit }
        format.json { render json: @article_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_published_status
    @article = Article.find(params[:id])
    @article.get_content(current_lang).toggle_published!

    respond_to do |format|
      notice =  if @article.get_content(current_lang).published?
                  'Супер статейка наконец-таки попала в свет!'
                else
                  'Ну вот.. А люди только начали ее читать...'
                end
      format.html { redirect_to to_back_url, notice: notice }
      format.json { head :no_content }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.remove!

    respond_to do |format|
      format.html { redirect_to admin_articles_path, notice: 'Гавностатья удалена! Завязывай такие писать..' }
      format.json { head :no_content }
    end

  end

  private
    def article_params
      params.require(:article).permit(:image, 
                                      :ru_title, :ru_content, :ru_short_description,
                                      :en_title, :en_content, :en_short_description,
                                      :ru_tags => [], :en_tags => []
                                      )
    end

    def to_back_url
      uri = URI.parse(request.referer) 
      uri.query = "lang=#{current_lang}"
      uri.to_s
    end
end
