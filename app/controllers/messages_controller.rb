class MessagesController < ApplicationController

  def new
    @message = Message.new
    @available_receiver = current_user.friends.order(:name)
  end

  def create
    receivers = params[:message][:receiver_id] ? params[:message][:receiver_id].compact.reject {|item| item.empty? } : []
    unless receivers.any?
      redirect_to new_message_path, flash: {error: "You should choose your friend to send message."}
    else
      receivers.each do |receiver|
        message = Message.new(message_params)
        message.receiver_id = receiver
        unless message.save
          redirect_to new_message_path, flash: {error: "Something goes wrong. Oops!"}
        end
      end
      redirect_to root_path , flash: {success: "Your message has been sent."}

      #
      # message = Message.new(message_params)
      # if @message.save
      #   redirect_to root_path , flash: {success: "Your message has been sent."}
      # else
      #   redirect_to new_message_path, flash: {error: "Something goes wrong. Oops!"}
      # end
    end
  end

  def get_sent_message
    @sent_messages = Message.where(sender_id: session[:user_id]).order("created_at desc") || []
    render 'send_message'
  end

  def index
    receiver_id = params[:receiver_id]
    @messages = Message.where(receiver_id: receiver_id).order("created_at desc") || []
    @new_message_count  = @messages.to_a.count {|message| message.read != true}
  end

  def show
    @message = Message.find params[:id]
    if @message.receiver_id != session[:user_id]
      redirect_to root_path, flash: {error: "Sorry! You can view your messages only."}
    else
    @message.read = true
    @message.read_at = DateTime.current
    @message.save
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :read)
  end

end
