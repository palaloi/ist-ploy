
class PortfolioController < ApplicationController
	before_filter :require_user, :only => [:upload , :upload_detail, :upload_save]
  def index
  end

  def upload
  	@portfolio = Portfolio.new
  end
  def upload_save
  	@user = current_user
  	@portfolio = Portfolio.new(params[:portfolio])
  	@portfolio.photo = params[:portfolio][:photo]
  	if @portfolio.save
  		flash[:notice] = "Your photo has been created."
      redirect_to portfolio_upload_detail_url(@portfolio)
  	else 
  		flash[:notice] = "There was a problem creating your portfolio."
      render :action => :upload
  	end
  end

  def upload_detail
  	@portfolio = Portfolio.find(params[:portfolio_id])
  end

  def show
  end
end
