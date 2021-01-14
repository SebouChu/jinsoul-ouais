class Admin::IdolsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :uuid, id_param: :uuid

  def index
    @idols = @idols.includes(:group).ordered.page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @idol.save
      redirect_to [:admin, @idol], notice: 'Idol was successfully created.'
    else
      render :new
    end
  end

  def update
    if @idol.update(idol_params)
      redirect_to [:admin, @idol], notice: 'Idol was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @idol.destroy
    redirect_to admin_idols_path, notice: 'Idol was successfully destroyed.'
  end

  private

  def idol_params
    params.require(:idol).permit(:name, :group_id)
  end
end
