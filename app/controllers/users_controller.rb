class UsersController < ApplicationController

	get '/signup' do 

		if logged_in?
			redirect '/conversations'
		else
			erb :'users/signup'
		end
	end

	post '/signup' do 
		
		@user = User.new(params)
		if @user.save
			session[:id] = @user.id
			redirect '/login'
		else
			redirect '/signup'
		end
	end

	get '/login' do
		if logged_in?
			redirect '/conversations'
		else
			erb :'users/login'
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/conversations'
		else
			redirect '/signup'
		end
	end

	get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:id' do
  	erb :'users/show'
  end

  # A users splashpage 

  # Show a users friends list 
    # Show their friends name 
    # show private channel button if their is a private channel 
    # show a button to create a private channel if there is no active private channel 
    # show a button to close a private channel if there is one active 




end