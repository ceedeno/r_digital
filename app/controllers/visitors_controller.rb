class VisitorsController < ApplicationController

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

  end


  def statistics
    authorize! :statistics, :user
  end


  def iframe
    
  end





end
