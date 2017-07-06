class MessagesController < ApplicationController
  before_action :set_group, only: [:index]

  def index
    @messages = @group.messages.includes(:user)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@message.group_id), notice: "メッセージが送信されました"
    else
      @group = Group.find(current_user.id)
      @groups = current_user.groups
      flash[:alert] = 'メッセージを入力してください'
      render :index
    end
  end


  private

  def set_group
    @group = Group.find(current_user.id)
    @groups = current_user.groups
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:body, :image, :group_id)
  end

end
