class MessagesController < ApplicationController
  before_action :set_group, only: [:index]

  def index
  end

  def new
  end

  def create
  end


  private

  def set_group
    @groups = current_user.groups
  end

end
