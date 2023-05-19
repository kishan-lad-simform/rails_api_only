class Api::V1::CommentsController < ApplicationController
  before_action :find_article, only: [ :index, :create, :show ]
  before_action :find_comment, only: [ :destroy, :update ]
  def index
    @comments = @article.comments
    render json: @comments, status: 200
  end

  def create
    @comment = @article.comments.create(comment_param)
    if @comment.save
      render json: @comment, status: 200
    else
      redner json: @comment, status: 422
    end
  end

  def update
    
    if @comment.update(comment_param)
      render json: @comment, status: 200
    else
      render json: @comment, status: 422
    end
  end

  def destroy
    
    @comment.destroy
    render json: @comment, status: 200
  end

  def show
    @comments = @article.comments.find(params[:id])
    render json: @comments, status: 200
  end

  def search_comment
    if params[:comment].blank?
      @comments = Comment.all
      render json: @comments, status: 200
    else
      @comment = Comment.where("comment LIKE ?", "%#{params[:comment]}%")
      render json: @comment, status: 200
    end
  end

  private

    def comment_param
      params.require(:comment).permit(
        :comment,
        :date_of_comment
      )
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end

    def find_article
      @article = Article.find(params[:article_id])
    end
end
