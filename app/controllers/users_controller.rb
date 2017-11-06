class UsersController < ApplicationController

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

  def index
    authorize! :users_index, :user

    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user or current_user.director?
      #redirect_to :back, :alert => "Access denied."
      redirect_back fallback_location: root_path, notice: 'No tienes acceso'
    end
  end

  def edit
    @user = User.find(params[:id])

  end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to users_path, notice: '¡El usuario fue actualizado con éxito!'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end


  def destroy
    @user = User.find(params[:id])

    @user.destroy

    respond_to do |format|
      format.html {redirect_to users_path, notice: '¡El usuario fue eliminado con éxito!'}
      format.json {head :no_content}
    end

  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

end
