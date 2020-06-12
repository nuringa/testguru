class Admin::BadgesController < Admin::BaseController
  before_action :authenticate_user!
  before_action :find_badge, only: %i[show edit update destroy]

  def show; end

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badges_path, notice: 'Badge was successfully created'
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badges_path, notice: 'Badge was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @badge.delete
    redirect_to admin_badges_path, notice: 'Badge was successfully deleted'
  end

  private

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:name, :url, :rule_name, :rule_value)
  end
end
