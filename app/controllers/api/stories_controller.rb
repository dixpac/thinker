class Api::StoriesController < ApplicationController
  before_action :authenticate_user!

  def update
    @story = current_user.stories.find(params[:id])
    @story.assign_attributes(story_params)

    if @story.published?
      @story.save
    else
      @story.save_draft
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :body, :picture)
  end

end
