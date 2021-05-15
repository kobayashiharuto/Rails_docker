class Api::V1::PostsController < ApplicationController
  protect_from_forgery
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    articles = Article.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded articles', data: articles }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the post', data: @post }
  end

  def create
    article = Article.new(post_params)
    if post.save
      render json: { status: 'SUCCESS', data: article }
    else
      render json: { status: 'ERROR', data: article.errors }
    end
  end

  def destroy
    @article.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @article }
  end

  def update
    if @article.update(post_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @article }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @article.errors }
    end
  end

  private

  def set_post
    @article = Article.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title)
  end
end
