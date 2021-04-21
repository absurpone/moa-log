class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

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
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    @posts = Post.search(params[:keyword]).order('created_at DESC')
  end

  def search_hokkaido_tohoku
    @posts_hokkaido_tohoku = Post.search_hokkaido_tohoku.order('created_at DESC')
  end
  
  def search_kanto
    @posts_kanto = Post.search_kanto.order('created_at DESC')
  end

  def search_chubu
    @posts_chubu = Post.search_chubu.order('created_at DESC')
  end

  def search_kinki
    @posts_kinki = Post.search_kinki.order('created_at DESC')
  end

  def search_chugoku_shikoku
    @posts_chugoku_shikoku = Post.search_chugoku_shikoku.order('created_at DESC')
  end

  def search_kyusyu_okinawa
    @posts_kyusyu_okinawa = Post.search_kyusyu_okinawa.order('created_at DESC')
  end


  private

  def post_params
    params.require(:post).permit(images: [], :prefecture_id, :rating, :museum_name, :exhibition_title, :impressive_artist,
                                 :impressive_work, :text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user != @post.user
  end
end
