class User < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_authentic do |c|
  	c.login_field = 'login'
  end # block optional

  attr_accessible :name, :login, :email, :password, :password_confirmation
end
