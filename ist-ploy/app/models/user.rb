class User < ActiveRecord::Base
  # attr_accessible :title, :body
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
end
