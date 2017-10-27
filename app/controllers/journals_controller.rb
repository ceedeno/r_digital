class JournalsController < ApplicationController

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json {head :forbidden, content_type: 'text/html'}
      format.html {
        flash[:danger] = exception.message
        redirect_to root_path
      }
      format.js {head :forbidden, content_type: 'text/html'}
    end
  end


  before_action :authenticate_user!
  before_action :set_journal, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /journals
  # GET /journals.json
  def index

    if params[:term]
      @journals = Journal.where(status: :published).joins(:articles).where('articles.key_words LIKE ?', "%#{params[:term]}%").uniq
    else
      if current_user.director? || current_user.admin?
        @journals = Journal.all
      else
        @journals = Journal.where(status: :published)
      end
    end

  end

  # GET /journals/1
  # GET /journals/1.json
  def show
  end

  # GET /journals/new
  def new
    @journal = Journal.new
  end

  # GET /journals/1/edit
  def edit
  end

  # POST /journals
  # POST /journals.json
  def create
    @journal = Journal.new(journal_params)

    respond_to do |format|
      if @journal.save
        format.html {redirect_to @journal, notice: 'Journal was successfully created.'}
        format.json {render :show, status: :created, location: @journal}
      else
        format.html {render :new}
        format.json {render json: @journal.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /journals/1
  # PATCH/PUT /journals/1.json
  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html {redirect_to @journal, notice: '¡La revista fue actualizada con éxito!'}
        format.json {render :show, status: :ok, location: @journal}
      else
        format.html {render :edit}
        format.json {render json: @journal.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /journals/1
  # DELETE /journals/1.json
  def destroy
    @journal.destroy
    respond_to do |format|
      format.html {redirect_to journals_url, notice: 'Journal was successfully destroyed.'}
      format.json {head :no_content}
    end
  end


  def combine_pdfs
    @journal = Journal.find(params[:journal_id])


    @journal.combine_pdfs
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_journal
    @journal = Journal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def journal_params
    params.require(:journal).permit(:identifier, :editor, :publisher, :indexing, :cover, :copyright, :subject, :others, :file_name, :status, :term, article_ids: [])
  end
end
