class GroupsController < ApplicationController
  def index
    @group = Group.all
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
    group_find
  end

  def update
    group_find
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

  def group_find
    @group = Group.find(params[:id])
  end
end
