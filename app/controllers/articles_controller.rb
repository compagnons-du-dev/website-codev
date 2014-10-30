class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def show
    @contents = @article.contents.order(:position)
  end

  def index
    @articles = Article.where(publish: true).order(created_at: :desc).paginate(page: params[:page], per_page: 7)
  end

  def set_article
    @article = Article.friendly.find params[:id]
  end
end
