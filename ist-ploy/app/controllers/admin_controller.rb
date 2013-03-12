
class AdminController < ApplicationController
	require 'csv'
	def index
		@user = User.find(params[:user_id])
		@title = "Administration"
	end

	def new_user
		@title = "Add new user"
		@users = User.order("created_at desc")
		@action = "all"
		if params[:action_link]
			if params[:action_link] == "all"
				@users = User.order("created_at desc")
				@action = "all"
			elsif params[:action_link] == "student"
				@users = User.find(:all, :conditions => {:user_type_id => UserType.find_by_name("Student").id}, :order => "created_at desc")
				@action = "student"
			elsif params[:action_link] == "teacher"
				@users = User.find(:all, :conditions => {:user_type_id => UserType.find_by_name("Teacher").id}, :order => "created_at desc")
				@action = "teacher"
			elsif params[:action_link] == "staff"
				@users = User.find(:all, :conditions => {:user_type_id => UserType.find_by_name("Staff").id}, :order => "created_at desc")
				@action = "staff"
			end
				
		end
	end
	def create_user
		uploaded_user = params[:new_user]
		unless uploaded_user.nil?
			original_filename = uploaded_user.original_filename
			file_extension = original_filename.split('.').pop() #get the extension by spliting using (.)
			if (file_extension != "csv") 
				flash[:error_notice] = ".#{file_extension} is not allowed. Only .csv extension is allowed."
				redirect_to :action => :new_user
			else 
				CSV.foreach(uploaded_user.tempfile, :headers => true) do |row|
				  # Moulding.create!(row.to_hash)
				  # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #{row['login']}"
				  user = User.new
				  user.login = row['login']
				  user.password = row['password']
				  user.password_confirmation = row['password']
				  user.name = row['id']
				  user.firstname = row['firstname']
				  user.lastname = row['lastname']
				  user.email = row['email']
				  user.user_type = UserType.find_by_name(row['user_type'])
				  puts "#{user.inspect}"
				  user.save!
				end
				flash[:notice] = "Successfully upload new user."
				redirect_to :action => :new_user
			end
		else 
			flash[:error_notice] = "You have to select aleast one CSV file to upload. "
			redirect_to :action => :new_user
		end
		
	end
end

