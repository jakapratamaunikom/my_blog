class Admin::WorksController < Admin::BaseController
  add_tasty_breadcrumb 'Мои работы',  :admin_works_path

  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
    add_tasty_breadcrumb @work.get_content(current_lang).title, admin_work_path(@work)
  end

  def new
    add_tasty_breadcrumb 'Создание новой работы', :new_admin_work_path
    @work = Work.new
    @work_form = VAlexL::MyBlog::FormObjects::Work.new @work
  end

  def create
    @work = Work.new
    @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, work_params

    respond_to do |format|
      if @work_form.save
        format.html { redirect_to [:admin, @work_form.work], notice: 'Создано описание об очередной твоей крутой работенке' }
        format.json { render :show, status: :created, location: @work_form.work }
      else
        add_tasty_breadcrumb 'Создание', :new_admin_work_path

        format.html { render :new }
        format.json { render json: @work_form.errors, status: :unprocessable_entity }
      end
    end    
  end

  def edit
    @work = Work.find(params[:id])
    @work_form = VAlexL::MyBlog::FormObjects::Work.new @work
    
    add_tasty_breadcrumb @work.get_content(current_lang).title, admin_work_path(@work)
    add_tasty_breadcrumb 'Редактирование', edit_admin_work_path(@work)
  end

  def update
    @work      = Work.find(params[:id])
    @work_form = VAlexL::MyBlog::FormObjects::Work.new @work, work_params

    respond_to do |format|
      if @work_form.save
        format.html { redirect_to admin_work_path(@work_form.work, lang: current_lang), notice: 'Йо! Теперь ты описал свою работу еще лучше!!!' }
        format.json { render :show, status: :ok, location: @work_form.work }
      else
        add_tasty_breadcrumb @work_form.work.get_content(current_lang).title, admin_work_path(@work)
        add_tasty_breadcrumb 'Редактирование', edit_admin_work_path(@work)

        format.html { render :edit }
        format.json { render json: @work_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_published_status
    @work = Work.find(params[:id])
    @work.get_content(current_lang).toggle_published!

    respond_to do |format|
      notice =  if @work.get_content(current_lang).published?
                  'Супер проект наконец-таки попала в свет! И люди увидят как ты крут!'
                else
                  'Удалил! Поздравляю! Теперь ты настолько крут, что это проект не повод для гордости!'
                end
      format.html { redirect_to to_back_url, notice: notice }
      format.json { head :no_content }
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.remove!

    respond_to do |format|
      format.html { redirect_to admin_works_path, notice: 'Гавнопроект удалена! Завязывай о таких писать..' }
      format.json { head :no_content }
    end

  end

  private
    def work_params
      params.require(:work).permit(:image,
                                   :ru_title, :ru_content,
                                   :en_title, :en_content,
                                   :image_ids => [],
                                  )
                                      
    end

    def to_back_url
      uri = URI.parse(request.referer) 
      uri.query = "lang=#{current_lang}"
      uri.to_s
    end
end
