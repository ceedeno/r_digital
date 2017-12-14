class VolumesController < ApplicationController

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

  load_and_authorize_resource


  before_action :authenticate_user!


  before_action :set_volume, only: [:show, :edit, :update, :destroy]

  # GET /volumes
  # GET /volumes.json
  def index
    @volumes = Volume.all

    authorize! :volume_index, :volume

  end

  # GET /volumes/1
  # GET /volumes/1.json
  def show
  end

  # GET /volumes/new
  def new
    @volume = Volume.new
  end

  # GET /volumes/1/edit
  def edit
  end

  # POST /volumes
  # POST /volumes.json
  def create
    @volume = Volume.new(volume_params)

    respond_to do |format|
      if @volume.save
        format.html {redirect_to @volume, notice: '¡El volumen has sido creado con éxito!'}
        format.json {render :show, status: :created, location: @volume}
      else
        format.html {render :new}
        format.json {render json: @volume.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /volumes/1
  # PATCH/PUT /volumes/1.json
  def update
    respond_to do |format|
      if @volume.update(volume_params)
        format.html {redirect_to @volume, notice: '¡El volumen has sido actualizado con éxito!'}
        format.json {render :show, status: :ok, location: @volume}
      else
        format.html {render :edit}
        format.json {render json: @volume.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /volumes/1
  # DELETE /volumes/1.json
  def destroy
    @volume.destroy
    respond_to do |format|
      format.html {redirect_to volumes_url, notice: '¡El volumen has sido eliminado con éxito!'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_volume
    @volume = Volume.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def volume_params
    params.require(:volume).permit(:number, :pages, :creation_date)
  end
end
