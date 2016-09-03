class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  layout "editor", only: [:new, :edit, :create, :update]

  def index
    @stories = current_user.stories
  end

  def show
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.build(story_params)
    if @story.save
      redirect_to @story, notice: "Successfully published the post!"
    else
      #@post.unpublish
      flash.now[:alert] = "Could not update the post, Please try again"
      render :new
    end
  end

  def edit
  end

  def update
    @story.assign_attributes(post_params)
    if @story.save
      redirect_to @story, notice: "Successfully published the post!"
    else
      flash.now[:alert] = "Could not update the post, Please try again"
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to root_url, notice: "Successfully deleted the post"
  end

  # TODO: ideally move this to a separate controller?
  def create_and_edit
    #@story = current_user.posts.build(post_params)
    #@story.save_as_draft
   # redirect_to edit_story_url(@story)
  end

  private

    def story_params
      params.require(:story).permit(:title, :body, :picture)
    end

    def authorize_user
      begin
        @story = current_user.stories.find(params[:id])
      rescue
        redirect_to root_url
      end
    end
end
