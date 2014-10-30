class Admin::PagesController < AdminController
  before_filter :set_page, only: [:edit, :update, :destroy, :update]
  before_filter :set_category, only: [:create, :update]
  before_filter :set_tags, only: [:create, :update]

  def index
    @pages =  Page.all.order :category_id
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_path
  end

  def update
    if @page.update_attributes(page_params)
      @page.tags.destroy_all
      @tags.each {|name| @page.tags.create(name: name.downcase) } if @tags
    end
    redirect_to @page
  end

  def edit
    @content = Content.new
  end

  def create
    @page = Page.new page_params

    if @page.save
      @page.tags.destroy_all
      @tags.each {|name| @page.tags.create(name: name.downcase) } if @tags
      redirect_to edit_admin_page_path(@page)
    else
      render :new
    end
  end

  def new
    @page = Page.new
  end

  private

  def page_params
    custom_params = params.require(:page).permit(:name, :publish)
    custom_params.merge!(category_id: @category.id) if @category

    custom_params
  end
  def set_page
    @page = Page.friendly.find params[:id]
  end
  def set_category
    @category = Category.find_by(name: params[:page][:category].parameterize) if params[:page][:category]
  end

  def set_tags
    if tags = params.require(:page).permit(:tags)[:tags]
      @tags = tags.split(/(#| )/).reject {|e| (e[/(#|\s)/] || e.empty?) }
    else
      false
    end
  end
end
