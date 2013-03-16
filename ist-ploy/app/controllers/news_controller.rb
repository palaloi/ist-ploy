
class NewsController < ApplicationController
  def activity
  	@title = "News | Activity"
  	@action = "activity"
  end
  def contest 
  	@title = "News | Contest"
  	@action = "contest"
  end
  def job
  	@title = "News | Job"
  	@action = "job"
  end
end
