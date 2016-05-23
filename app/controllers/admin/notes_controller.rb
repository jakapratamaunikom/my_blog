class Admin::NotesController < Admin::BaseController
  add_tasty_breadcrumb 'Заметки',  :admin_notes_path

  def index
    @notes = Note.page(params[:page]).per(10)
  end

  def show
    @note = Note.find(params[:id])
    add_tasty_breadcrumb @note.title, admin_note_path(@note)
  end

  def new
    add_tasty_breadcrumb 'Создание новой заметки', :new_admin_note_path
    @note = Note.new
    @note_form = VAlexL::MyBlog::FormObjects::Note.new @note
  end

  def create
    @note = Note.new
    @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, note_params

    respond_to do |format|
      if @note_form.save
        format.html { redirect_to [:admin, @note_form.note], notice: 'Заметка создана' }
        format.json { render :show, status: :created, location: @note_form.note }
      else
        add_tasty_breadcrumb 'Создание', :new_admin_note_path

        format.html { render :new }
        format.json { render json: @note_form.errors, status: :unprocessable_entity }
      end
    end    
  end

  def edit
    @note = Note.find(params[:id])
    @note_form = VAlexL::MyBlog::FormObjects::Note.new @note

    add_tasty_breadcrumb 'Редактирование', edit_admin_note_path(@note)
  end

  def update
    @note = Note.find(params[:id])
    @note_form = VAlexL::MyBlog::FormObjects::Note.new @note, note_params

    respond_to do |format|
      if @note_form.save
        format.html { redirect_to [:admin, @note_form.note], notice: 'Заметка изменена' }
        format.json { render :show, status: :ok, location: @note }
      else
        add_tasty_breadcrumb 'Редактирование', edit_admin_note_path(@note)

        format.html { render :edit }
        format.json { render json: @note_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy!

    respond_to do |format|
      format.html { redirect_to admin_notes_path, notice: 'Заметка удалена' }
      format.json { head :no_content }
    end
  end

  private
    def note_params
      params.require(:note).permit(:title, :description)
    end
end  
