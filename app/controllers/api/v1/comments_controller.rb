class Api::V1::CommentsController < ApplicationController
  def index
    find_article
    @comments = @article.comments.all
    render json: @comments, status: 200
  end

  def create
    find_article
    @comment = @article.comments.create(comment_param)
    if @comment.save
      render json: @comment, status: 200
    else
      redner json: @comment, status: 422
    end
  end

  def update
    find_comment
    if @comment.update(comment_param)
      render json: @comment, status: 200
    else
      render json: @comment, status: 422
    end
  end

  def destroy
    find_comment
    @comment.destroy
    render json: @comment, status: 200
  end

  def show
    find_article
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
