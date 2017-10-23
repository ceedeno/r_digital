class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /articles
  # GET /articles.json
  def index

    if current_user.basic?
      @articles = current_user.articles
    elsif current_user.ecm?
      @articles = Article.where(status: :basic)
    elsif current_user.referee?
      @articles = Article.where(referee_1: current_user).or(Article.where(referee_2: current_user)).or(Article.where(referee_3: current_user))
    elsif current_user.tmdcm?
      @articles = Article.where(status: :approved)
    elsif current_user.director?
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
        format.html {redirect_to @article, notice: 'Article was successfully created.'}
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
      if @article.update(article_params.merge(user_id: current_user.id))
        @journal = @article.journal if @article.journal
        format.html {redirect_to @article, notice: 'Article was successfully updated.'}
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
      format.html {redirect_to articles_url, notice: 'Article was successfully destroyed.'}
      format.json {head :no_content}
    end
  end


  # PATCH articles/:article_id/update_users_article
  def update_users_article
    @article = Article.find(params[:article_id])

    @article.update_users_article(current_user, params[:status], params[:note], params[:referee_1_id],
                                  params[:referee_2_id], params[:referee_3_id])

    respond_to do |format|
      format.html {redirect_to @article, notice: 'Article was successfully updated.'}
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
    params.require(:article).permit(:title, :abstract, :author, :status, :file, :position, :journal_id, :key_words,
                                    :referee_1_id, :referee_2_id, :referee_3_id, :tmdcm_1_id, :tmdcm_2_id,
                                    :tmdcm_1_review, :tmdcm_2_review)
  end
end
