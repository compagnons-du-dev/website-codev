class Admin::CategoriesController < AdminController
  before_filter :set_category, only: [:edit, :update, :destroy, :update]

  def index
    @categories =  Category.all
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  def update
    @category.update_attributes category_params
    redirect_to admin_categories_path
  end

  def edit
    
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  private

  def category_params
    params.require(:category).permit(:name, :category)
  end
  def set_category
    @category = Category.find params[:id]
  end
end
