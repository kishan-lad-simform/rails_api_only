class Api::V1::ArticlesController < ApplicationController
  def index
    all_articles
    render json: @articles, status: 200
  end

  def create
    @article = Article.create(article_param)
    if @article.save
      render json: @article, status: 200
    else
      redner json: @article, status: 422
    end
  end

  def update
    find_article
    if @article.update(article_param)
      render json: @article, status: 200
    else
      render json: @article, status: 422
    end
  end

  def destroy
    find_article
    @article.destroy
    render json: @article, status: 200
  end

  def show
    find_article
    render json: @article, status: 200
  end

  def search
    if params[:title].blank?
      all_articles
      render json: @articles, status: 200
    else
      @article = Article.where("title LIKE ?", "%#{params[:title]}%")
      render json: @article, status: 200
    end
  end

  def pagination
    @articles = Article.paginate(page: params[:page], per_page: 3)
    render json: @articles, status: 200
  end

  private
    def article_param
      params.require(:article).permit(
        :title,
        :body,
        :release_date
      )
    end

    def find_article
      @article = Article.find(params[:id])
    end

    def all_articles
      @articles = Article.all
    end
end
