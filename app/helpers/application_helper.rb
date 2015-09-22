module ApplicationHelper
  def controller_and_action
    "#{params[:controller]}_#{params[:action]}"
  end
end
