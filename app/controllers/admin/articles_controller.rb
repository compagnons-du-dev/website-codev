class Admin::ArticlesController < AdminController
  before_filter :set_article, only: [:edit, :update, :destroy, :update]
  before_filter :set_tags, only: [:create, :update]

  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path
  end

  def update
    if @article.update_attributes(article_params)
      @article.tags.destroy_all
      @tags.each {|name| @article.tags.create(name: name.downcase) } if @tags
    end
    redirect_to @article
  end

  def edit
    @content = Content.new
    @contents = @article.contents.order(:position)
  end

  def create
    @article = Article.new article_params

    if @article.save
      @article.tags.destroy_all
      @tags.each {|name| @article.tags.create(name: name.downcase) } if @tags
      redirect_to edit_admin_article_path(@article)
    else
      render :new
    end
  end

  def new
    @article = Article.new
  end

  private

  def article_params
    params.require(:article).permit(:name, :image, :publish)
  end
  def set_article
    @article = Article.friendly.find params[:id]
  end


  def set_tags
    if tags = params.require(:article).permit(:tags)[:tags]
      @tags = tags.split(/(#| )/).reject {|e| (e[/(#|\s)/] || e.empty?) }
    else
      false
    end
  end
end

