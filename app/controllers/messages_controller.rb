class MessagesController < ApplicationController
  def index
    set_group
  end

  private

  def set_group
    @groups = current_user.groups
  end

end
