
class UsersController < ApplicationController
	before_filter :require_user,  :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save
      flash[:notice] = "Your account has been created."
      redirect_to signup_url
    else
      flash[:notice] = "There was a problem creating you."
      render :action => :new
    end

  end

  def show
    @user = current_user
  end

  def edit
    @title = "Account | Profile"
    if !current_user
      redirect_to root_url
    else
      @user = current_user
    end
  end
  def edit_password
    @title = "Account | Password"
    if !current_user
      redirect_to root_url
    else
      @user = current_user
    end
  end
  def edit_about
    @title = "Account | Bio"
    if !current_user
      redirect_to root_url
    else
      @user = current_user
    end
  end
  def edit_skill
    @title = "Account | Skill"
    if !current_user
      redirect_to root_url
    else
      @user = current_user
      @skills = Skill.all
    end
  end


  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user]) or params[:skill]
      unless params[:skill]
        flash[:notice] = "Account updated!"
        redirect_to account_url  
      else
        params[:skill].each do |k,v|
          skill = @user.skill_users.find_by_skill_id(k.to_i)
          unless skill.nil?
            skill.update_attribute("skill_value", v[0].to_i)
          else
            SkillUser.create(:user_id => @user.id, :skill_id => k.to_i, :skill_value => v[0].to_i)
          end
        end
        redirect_to account_url 
      end      
    else
      if params[:target]
        render :action => params[:target]
      else
        render :action => :edit
      end
    end
  end
end
