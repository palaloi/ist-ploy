class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :skill_users
  has_many :skills, :through => :skill_users
  acts_as_authentic do |c|
  	c.login_field = 'login'
  end # block optional
  #paperclip
  has_attached_file :photo,
  	:styles => {
      :thumb=> "100x100#",
      :small  => "400x400>" 
  	},
  	:default_url => "missing.png"
  attr_accessible :name, :login, :email, :password, :password_confirmation, :location, :web_site, :about_you, :photo
  acts_as_messageable
  
  def name
    self[:name]
  end

  def mailboxer_email(object)
    email
  end  
  
end
