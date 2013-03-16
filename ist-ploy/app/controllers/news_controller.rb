
class NewsController < ApplicationController
  def activity
  	@title = "News | Activity"
  	@action = "activity"
  end
  def contest 
  	@title = "News | Contest"
  	@action = "contest"
  end
end
