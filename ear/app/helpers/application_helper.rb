# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def sort_link(title, column, options = {})
    condition = options[:unless] if options.has_key?(:unless)
    sort_dir = params[:direction] == 'up' ? 'down' : 'down'
    link_to_unless condition, title, request.parameters.merge( {:order => column, :direction => sort_dir} )
  end
  
  
	
end
