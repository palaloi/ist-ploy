
class MessagesController < ApplicationController
	before_filter :require_user
  def index
  	@user = current_user
  	#Paginating received conversations using :page parameter and 9 per page
		# @inboxes = current_user.mailbox.inbox.page(params[:page]).per(9)
		@inboxes = current_user.mailbox.inbox
		@title = "Message"
  end

  def compose
  end

  def sent
  end
end
