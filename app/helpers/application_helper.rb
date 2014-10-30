module ApplicationHelper
  def color
    cycle 'success', 'primary', 'info', 'danger', 'warning', 'default'
  end

  def full_title(page_title)
  page_title.empty? ? 'Compagnons du dev' : "Compagnons du dev | #{page_title}"
  end
  
  def body_id(controller, action)
    "#{controller.parameterize}-#{action.parameterize}"
  end

end
