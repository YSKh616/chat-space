class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]

  def index
    @messages = @group.messages.includes(:user)
    @message = Message.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json
      end
    else
      @group = Group.find(params[:group_id])
      @groups = current_user.groups
      @messages = @group.messages.includes(:user)
      flash[:alert] = 'メッセージを入力してください'
      render :index
    end
  end


  private

  def set_group
    @group = Group.find(params[:group_id])
    @groups = current_user.groups
  end

  def message_params
    params.require(:message).permit(:body, :image, :group_id)
  end

end
