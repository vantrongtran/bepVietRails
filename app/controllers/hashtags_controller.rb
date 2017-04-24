class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.search(params[:hashtag]).first(8)
  end
end
