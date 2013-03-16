
class PortfolioController < ApplicationController
	before_filter :require_user, :only => [:upload , :upload_detail, :upload_save]
  def index
    @user = current_user
  end

  def upload
  	@portfolio = Portfolio.new
    @title = "Upload file"
    @user = current_user
  end
  def upload_save
  	@user = current_user
  	@portfolio = Portfolio.new(params[:portfolio])
    if params[:portfolio].nil? or params[:portfolio][:photo].nil?
      flash[:error_notice] = "Attached file can not be blank."
      render :action => :upload
    else 
      @portfolio.user_id = @user.id
    	
      # extension = params[:portfolio][:photo].original_filename.split(".").last
      # puts "extension = #{extension}"
      # if extension == "zip" or extension == "rar"
      #   puts "zippppp"
      #   @portfolio.zip = params[:portfolio][:photo] unless params[:portfolio].nil?
      # elsif  extension == "jpg" or extension == "png" or extension == "gif"
      #   puts "photoooo"
        @portfolio.photo = params[:portfolio][:photo] unless params[:portfolio].nil?
      # end
    	if @portfolio.save

    		flash[:notice] = "Your attached file has been created."
        redirect_to portfolio_upload_detail_url(@portfolio)
    	else 
    		# flash[:notice] = "There was a problem creating your portfolio."
        flash[:error_notice] = @portfolio.errors.full_messages.to_sentence
        render :action => :upload
    	end
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
        existing_tag = PortfolioTag.find(:all, :conditions => {:tag_id => tag.id, :portfolio_id => @portfolio.id})
        PortfolioTag.create(:tag => tag, :portfolio => @portfolio) unless existing_tag.any?
      else 
        PortfolioTag.create(:tag => Tag.create(:name => d), :portfolio => @portfolio)
      end
      # @portfolio.tags.push(Tag.find_by_name(d)) unless Tag.find_by_name(d).nil?
    end unless params[:hidden_tag].blank?
    if @portfolio.save
     redirect_to portfolio_show_path({:portfolio_id => @portfolio.id, :user_id => @user.id})
    else
      render :action => :upload_detail, :params => {:portfolio => @portfolio.id}
    end
  end

  def show
    @user = User.find(params[:user_id])
    @current_user = current_user
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio["tags"] = @portfolio.portfolio_tags
    @title =  @portfolio.title.nil?? "Portfolio: " + @user.name: "Portfolio: "+ @portfolio.title
    @isAdmin = @current_user.user_type == UserType.find_by_name("Admin") unless @current_user.user_type.nil?
  end

  def feed
    @title = "Portfolio Feed"
    @categories = PortfolioCategory.order("name asc")
    @portfolio = Portfolio.order("created_at DESC")
    @tags = Tag.all
    @action = "recent"
    @user = current_user
    @user_type = UserType.where("name != 'Admin'")
    if params[:category]
      @portfolio = Portfolio.find(:all, :conditions => {:portfolio_category_id => params[:category]}, :order => "created_at DESC")
      @action = "category"
    elsif params[:tag]
      @portfolio = Tag.find(params[:tag]).portfolios
      @action = "tag"
    elsif params[:user_type]
      @users = User.find(:all, :conditions => {:user_type_id => params[:user_type]})
      @portfolio = Portfolio.find(:all, :conditions => {:user_id => @users}) unless @users.nil?
      @action = "user_type"
    elsif params[:action]
      if params[:action] == "recent"
        @portfolio = Portfolio.order("created_at DESC")  
        @action = "recent"
      end
    else 
      @portfolio = Portfolio.order("created_at DESC")
    end
    # respond_to do |format|
    #   format.json { render :json => {:portfolio => @portfolio } } 
    # end
  end

  def feed_file
    @title = "Portfolio Feed File"
    @portfolio = Portfolio.order("created_at DESC")
    @user = current_user
  end
  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @user = current_user
    name = @portfolio.title unless @portfolio.nil?
    if @portfolio.destroy
      flash[:notice] = "Successfully delete portfolio named #{name}."
      redirect_to :action => :feed
    else
      flash[:error_notice] = "Could not delete portfolio named #{@portfolio.title}."
      render :action => :show , :params => {:user_id => current_user.id, :portfolio_id => @portfolio.id}
    end
  end
  def multi_delete_port
    @user = current_user
    puts "))))((((((((((((("
    port_ids =  params[:hidden_port_id].first.split(",") unless params[:hidden_port_id].nil?
    puts "first #{params[:hidden_port_id].first}"
    puts "port_ids = #{port_ids}"
    port_ids.each do |port|
      Portfolio.find(port).destroy
    end unless port_ids.nil?
    flash[:notice] = "Successfully delete portfolio."
    redirect_to admin_manage_portfolio_path
  end
  def how_to_use
    @title = "Help"
  end
end
