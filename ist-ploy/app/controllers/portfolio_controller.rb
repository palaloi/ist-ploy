
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
    @user = current_user
  	@portfolio = Portfolio.find(params[:portfolio_id])
    @title =  @portfolio.title.nil?? "Portfolio: " + @user.name: "Portfolio: "+ @portfolio.title
    @portfolio_category = PortfolioCategory.all
    @tag = Tag.find(:all,:select=>'name').map(&:name)
    @portfolio["tags"] = @portfolio.portfolio_tags
  end
  def upload_detail_save
    @user = current_user
    @portfolio = Portfolio.find(params[:id])
    @portfolio.title = params[:title]
    @portfolio.detail = params[:detail]
    @portfolio.portfolio_category_id = params[:portfolio_category]
    params[:hidden_tag].split(",").each do |d|
      tag = Tag.find_by_name(d)
      unless tag.nil?
        puts "Tagggggggg #{tag.id}"
        puts "Porttttttt #{@portfolio.id}"
        existing_tag = PortfolioTag.find(:all, :conditions => {:tag_id => tag.id, :portfolio_id => @portfolio.id})
        puts "existing_tag ====> #{existing_tag}"
        puts "existing_tag.nil? #{existing_tag.nil?}"
        puts "================= #{d}"
        PortfolioTag.create(:tag => tag, :portfolio => @portfolio) unless existing_tag.any?
      else 
        PortfolioTag.create(:tag => Tag.create(:name => d), :portfolio => @portfolio)
      end
      
      # @portfolio.tags.push(Tag.find_by_name(d)) unless Tag.find_by_name(d).nil?
    end unless params[:hidden_tag].blank?
    if @portfolio.save
     redirect_to portfolio_show_path({:portfolio_id => @portfolio.id})
    else
      render :action => :upload_detail, :params => {:portfolio => @portfolio.id}
    end
  end

  def show
    @user = current_user
    @portfolio = Portfolio.find(params[:portfolio_id])
    @title =  @portfolio.title.nil?? "Portfolio: " + @user.name: "Portfolio: "+ @portfolio.title
  end
end
