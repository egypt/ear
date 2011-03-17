# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def sort_order(order)
      "#{(params[:order] || order.to_s).gsub(/[\s;'\"]/,'')} #{params[:direction] == 'up' ? 'ASC' : 'DESC'}"
  end

  a = Application.new

end
