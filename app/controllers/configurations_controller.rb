class ConfigurationsController < ApplicationController
  before_action :set_configuration, only: [:show, :update, :destroy]

  # GET /configurations
  def index
    @configurations = Configuration.all

    render json: @configurations
  end

  # GET /configurations/1
  def show
    render json: @configuration
  end

  # POST /configurations
  def create
    @configuration = Configuration.new(configuration_params)

    if @configuration.save
      render json: @configuration, status: :created, location: @configuration
    else
      render json: @configuration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /configurations/1
  def update
    if @configuration.update(configuration_params)
      render json: @configuration
    else
      render json: @configuration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /configurations/1
  def destroy
    @configuration.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_configuration
      @configuration = Configuration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def configuration_params
      params.require(:configuration).permit(:name, :value)
    end
end
