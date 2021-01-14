class Admin::GroupsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :uuid, id_param: :uuid

  def index
    @groups = @groups.ordered.page(params[:page])
  end

  def show
    @idols = @group.idols.ordered
  end

  def new
  end

  def edit
  end

  def create
    if @group.save
      redirect_to [:admin, @group], notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to [:admin, @group], notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_path, notice: 'Group was successfully destroyed.'
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
