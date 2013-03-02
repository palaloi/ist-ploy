module ApplicationHelper
	def request_from
    params[:controller] + "#" + params[:action]
    # ""
  end
end
