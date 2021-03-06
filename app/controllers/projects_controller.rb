class ProjectsController < ApplicationController
  before_action :set_project, only: %I[show update destroy create_events events]
  before_action :set_user, only: %I[events]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    if Project.build(params['project'])
      render json: @project, status: :created, location: @project
    else
      render json: { error: 'Could not build this project.' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(params['project'])
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  # POST /projects/1/events
  def create_events
    @project.create_event event_type, params
  end

  # GET /projects/1/events
  def events
    if @user.nil?
      render json: { error: 'unauthorized user' }
    else
      render json: @project.new_events(@user)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Determine the incoming event type
  def event_type
    headers = {}
    request.headers.each {|k, v| headers[k] = v}
    if headers.key? 'X-GitHub-Event'
      "github_#{headers['X-GitHub-Event']}".to_sym
    else
      'tracker'
    end
  end

  # Get user based on the token
  def set_user
    @user = User.where(token: params[:token]).first
  end
end
