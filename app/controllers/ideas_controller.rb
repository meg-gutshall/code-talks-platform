class IdeasController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_idea, only: %i[show edit update destroy]
  before_action :authenticate_user_can_change_idea!, only: %i[edit update destroy]

  # GET /ideas
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1
  def show; end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit; end

  # POST /ideas
  def create
    @idea = current_user.ideas.build(idea_params)

    if @idea.save
      redirect_to @idea, notice: 'Idea was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ideas/1
  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: 'Idea was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ideas/1
  def destroy
    @idea.destroy
    redirect_to ideas_url, notice: 'Idea was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def idea_params
    params.require(:idea).permit(:title, :description)
  end

  def authenticate_user_can_change_idea!
    return if @idea.user == current_user

    redirect_to ideas_url, notice: "You can't update that Idea"
  end
end
