class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :destroy]
  before_action :set_post, 

  def index
    @favorite_posts = current_user.favorite_posts
  end

  def create
    Favorite.create(user_id: current_user.id, post_id: params[:id])
    redirect_back(fallback_location: post_path(@post.id)) 
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, post_id: params[:id]).destroy
    redirect_back(fallback_location: post_path(@post.id))
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
