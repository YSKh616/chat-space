class GroupsController < ApplicationController
  def index
    @group = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def edit
    set_group_find
  end

  def update
    set_group_find
    if @group.update(group_params)
      redirect_to root_path, notice: "グループが更新されました"
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def set_group_find
    @group = Group.find(params[:id])
    @group_id = current_user.group_ids
  end
end
