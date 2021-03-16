class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_post, only: [:show, :edit]

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:image, :prefecture_id, :rating, :museum_name, :exhibition_title, :impressive_artist,
                                 :impressive_work, :text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
