class StatisticsController < ApplicationController

  before_action :authenticate_user!

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


  def index
    authorize! :statistics, :user

  end
end
