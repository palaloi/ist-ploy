class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :skill_users
  has_many :skills, :through => :skill_users
  has_many :portfolios
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
  belongs_to :user_type
  # validates_uniqueness_of :email, :allow_blank => true, :allow_nil => true
  
  attr_accessible :name, :login, :email, :password, :password_confirmation, :location, :web_site, :about_you, :photo, :firstname, :lastname
  # attr_accessible :displayname, :name, :surname, :username, :login, :email, :password, :password_confirmation, :location, :web_site, :about_you, :photo, :group

  acts_as_messageable
  
  def name
    self[:name]
  end

  def mailboxer_email(object)
    email
  end  
  
end
