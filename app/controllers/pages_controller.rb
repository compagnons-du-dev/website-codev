class PagesController < ApplicationController
  before_action :set_page, only: [:show]

  def show
    @contents = @page.contents.order(:position)
  end

  def set_page
    @page = Page.friendly.find params[:id]
  end
end
