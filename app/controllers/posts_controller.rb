class PostsController < ApplicationController
  before_action :load_post, only: :show

  def index
    @posts = params[:name] ? (Post.search_by_name( params[:name] ).page(params[:page]).per Settings.per_page.food): (Post.all.page(params[:page]).per Settings.per_page.food)
  end

  def show
    @comment = Comment.new
  end

  private

  def load_post
    @post = Post.find params[:id]
  end
end
