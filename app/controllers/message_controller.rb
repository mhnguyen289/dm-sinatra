

class MessagesController < ApplicationController

	get '/messages' do
		erb :'messages/messages'
	end

	get '/messages/:id' do

		# @conversation = Conversation.find(id)
		@user = User.find(params[:id])
		if logged_in?	
			erb :"/messages/messages"
		else
			redirect '/conversations'
		end
	end

	post '/messages/:id' do
		binding.pry
		# User.conversations.create!({title: 'let us chat', message, recepient_user_id})
		@conversation = Conversation.new
		@conversation.sender = current_user
		@conversation.recipient = User.find(params[:id])
		
		if params[:content] !=
		@user = User.find(params[:id])

		
			@user.messages.create(:content=>params[:content] )
			redirect "/messages/#{@user.id}"
		else
			redirect 'conversations/conversations'
		end
	end


	get '/conversation/message/:id' do
		@user = User.find(params[:id])
		if logged_in?
			erb :'message_conversations/message_conversations'
		else
			redirect '/conversation/:id'
		end
	end

	post '/conversation/message/:id' do
		if params[:content] != ""
			@user = User.all.find(params[:id])
			@user.messages.create(:content=>params[:content], :username => current_user.username)

			redirect "/conversation/message/#{@user.id}"
		else
			redirect '/conversation/:id'
		end
	end

	private

  def message_params
    params.require(:message).permit(:body)
  end

end
