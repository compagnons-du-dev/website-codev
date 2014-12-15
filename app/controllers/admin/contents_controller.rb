class Admin::ContentsController < AdminController
  before_filter :set_associate
  before_filter :set_content, except: [:create]

  def destroy
    unless @content.fixed
      @content.destroy
    end

    redirect_associate(@content)
  end

  def update
    if !params['position']
      @content.update_attributes(content_params)
    elsif params['position'] == 'up'
      @content.increment_position!
    else
      @content.decrement_position!
    end

    redirect_associate(@content)
  end

  def create
    @content = Content.new content_params

    unless @content.save
      flash[:alert_context] = {color: 'danger', messages: @content.errors.full_messages.map { |msg| msg } }
    end

    redirect_associate(@content)
  end

  private

  def content_params
    if @associate.class.name == 'Page'
      associate_hash = {page_id: @associate.id}
    elsif @associate.class.name == 'Article'
      associate_hash = {article_id: @associate.id}
    end

    hash = params.require(:content).permit(:value, :partial, :image, :file, :title, :link)
    if associate_hash
      hash.merge(associate_hash) 
    else
      hash
    end
  end

  def set_content
    @content = Content.find params[:id]
  end

  def set_associate
    if params[:page_id]
      @associate = Page.friendly.find params[:page_id]
    else
      @associate = Article.friendly.find params[:article_id]
    end
  end

  def redirect_associate(content)
    if content.page
      redirect_to content.page
    else
      redirect_to content.article
    end
  end
end
