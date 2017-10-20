class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
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


  private

  def user_params
    params.require(:user).permit(:role)
  end

end
