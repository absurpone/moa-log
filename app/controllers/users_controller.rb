class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @posts = user.posts
    # @favorites = Favorite.where(user_id: user.id)
  end
end
