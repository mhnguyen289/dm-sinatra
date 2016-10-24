class ApplicationController < Sinatra::Base
	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
	end

	helpers do

		def logged_in?
		  !!session[:id]
		end

		def current_user
		  @current_user ||= User.find(session[:id])
		end

		def error
			@error_message = params[:error]
		end

	end

	get '/' do 
		
		@conversation = Conversation.new
		@conversation.sender = current_user
		erb :'conversations/conversations'
	end

end