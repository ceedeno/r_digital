class ArticlesController < ApplicationController


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
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /articles
  # GET /articles.json
  def index

    if current_user.basic? || current_user.adviser?
      @articles = current_user.articles
    elsif current_user.ecm?
      @articles = Article.where(status: :basic)
    elsif current_user.referee?
      @articles = Article.joins(:selected_referee).where('selected_referees.referee_1_id = ?', current_user.id).or(Article.joins(:selected_referee).where('selected_referees.referee_2_id = ?', current_user.id)).or(Article.joins(:selected_referee).where('selected_referees.referee_3_id = ?', current_user.id))
    elsif current_user.tmdcm?
      @articles = Article.where(status: :approved)
    elsif current_user.director? || current_user.admin?
      @articles = Article.all
    else
      @articles = []
    end


    #@articles = Article.all

  end

  # GET /articles/1
  # GET /articles/1.json
  def show

    #redirect_to '/web/viewer.html?file='+ current_user.name
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    respond_to do |format|
      if @article.save
        format.html {redirect_to @article, notice: '¡El artículo fue creado con éxito!'}
        format.json {render :show, status: :created, location: @article}
      else
        format.html {render :new}
        format.json {render json: @article.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update

    @journal = @article.journal

    respond_to do |format|
      #if @article.update(article_params.merge(user_id: current_user.id))
      if @article.update(article_params)
        @journal = @article.journal if @article.journal
        format.html {redirect_to @article, notice: '¡El artículo fue editado con éxito!'}
        format.js {}
        format.json {render :show, status: :ok, location: @article}
      else
        format.html {render :edit}
        format.json {render json: @article.errors, status: :unprocessable_entity}
        format.js {}
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html {redirect_to articles_url, notice: '¡El artículo fue eliminado con éxito!'}
      format.json {head :no_content}
    end
  end


  # PATCH articles/:article_id/update_users_article
  def update_users_article
    @article = Article.find(params[:article_id])

    @article.update_users_article(current_user, params[:status], params[:note], params[:referee_1_id],
                                  params[:referee_2_id], params[:referee_3_id])

    respond_to do |format|
      format.html {redirect_to @article, notice: '¡El artículo fue actualizado con éxito!.'}
    end

  end

  def update_correction_note
    @article = Article.find(params[:article_id])
    @users_article = UsersArticle.find(params[:users_article_id])
    @users_article.update_attributes(correction_note: params[:correction_note], checked_by_director: true)

    respond_to do |format|
      format.html {redirect_to @article, notice: '¡Revision enviada con éxito!'}
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :abstract, :author, :kind, :status, :file, :position, :journal_id, :key_words,
                                    :referee_1_id, :referee_2_id, :referee_3_id, :tmdcm_1_id, :tmdcm_2_id,
                                    :tmdcm_1_review, :tmdcm_2_review, :checked_as_corrected, :language,
                                    selected_referee_attributes: [:id, :referee_1_id, :referee_2_id, :referee_3_id])
  end
end
