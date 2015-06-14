class MyWorksController < BaseController
  before_action do
    add_tasty_breadcrumb I18n.t("views.header.my_works"), :my_works_path
  end

  def index
    @works = Work.published(current_lang)
  end

  def show
    @work = Work.published(current_lang).find(params[:id])
    add_tasty_breadcrumb @work.get_content(current_lang).title, my_work_path(@work)
  end

  def preview
    @work = Work.find(params[:id])
    add_tasty_breadcrumb @work.get_content(current_lang).title, preview_my_work_path(@work)

    respond_to do |format|
      format.html { render :show }
    end
  end
end
