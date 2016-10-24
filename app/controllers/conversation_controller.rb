class ConversationsController < ApplicationController

	get '/conversations' do 

		if logged_in?
			erb :'conversations/conversations'
		else
			redirect '/login'
		end
	end

	post '/conversations' do 
		binding.pry
	end

	get '/conversations/new' do 
		if logged_in?
			erb :'conversations/new'
		else
			redirect '/login'
		end
	end

	post '/conversations/new' do 
		
		if params[:title] != ""
			@conversation = current_user.conversations.create(:title=>params[:title])
			redirect '/conversations'
		else
			redirect '/conversations/new'
		end
	end

	get '/conversations/:id' do 

		@conversation = Channel.find(params[:id])
		if logged_in?
			erb :'conversations/show'
		else
			redirect '/login'
		end
	end

	post '/conversations/:id' do 
		
		if params[:message] != ""
		@conversation = Channel.find(params[:id])
		@conversation.messages.create(:content=>params[:content])
			redirect "/conversations/#{@conversation.id}"
		else
			redirect '/conversations/show'
		end
	end

	get '/conversations/:id/edit' do
		
		if logged_in?
			@conversation = Channel.find(params[:id])
			
			erb :'conversations/edit'
		else
			redirect '/login'
		end
	end
	
	get '/conversations/:id/delete' do
		if logged_in?
			@conversation = Channel.find(params[:id])
			erb :'conversations/delete'
		else
			redirect '/login'
		end
	end

	post '/conversations/:id/delete' do
		@conversation = Channel.find(params[:id])
		@conversation.delete
		redirect '/conversations'
	end

	private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end

end