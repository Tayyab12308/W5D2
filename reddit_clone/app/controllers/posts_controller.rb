class PostsController < ApplicationController
  
  before_action :ensure_logged_in

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.author_id == current_user.id && @post.update(post_params)
      redirect_to post_url(@post)
    else  
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      @post.destroy
      redirect_to post_url(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end