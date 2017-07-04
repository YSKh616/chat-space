class MessagesController < ApplicationController
  def index
    set_group
  end

  private

  def set_group
    @group = current_user.groups
    @group_id = current_user.group_ids
  end

end
