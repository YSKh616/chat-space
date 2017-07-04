class MessagesController < ApplicationController
  def index
    set_group
  end

  private

  def set_group
    @group = current_user.groups
  end

end
