class PlansController < ApplicationController
  before_action :set_plan, only: [:edit, :update, :show, :check, :destroy]
  
  def new
   # @user = User.find(params[:id])
    @plan = Plan.new
  end
  
  def create
  #  @user = User.find(params[:id])
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id # user.idがnilでエラーとなるため
    if @plan.save
      flash[:success] = "チェックリストを作成しました。"
      redirect_to @current_user
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
    @checklists = Checklist.where(plan_id: @plan.id)
  end
  
  def update
    if @plan.update_attributes(plan_params) # フォーム追加したものだけが飛んできている
      flash[:success] = "チェックリストを更新しました。"
      redirect_to current_user
    else
      render :edit
    end
  end
  
  def destroy
    @plan.destroy
    flash[:success] = "#{@plan.subject}を削除しました。"
    redirect_to user_url(@plan.user_id)
  end
  
  def check
    check_params.each do |id, other|
      checklist = Checklist.find(id)
      checklist.update_attributes(other)
    end
    flash[:success] = "チェックしました。"
    redirect_to current_user
  end
  
    
  
  private
  
  def plan_params
    params.require(:plan).permit(:subject, :departure_at, checklists_attributes: [:id, :plan_id, :item, :check, :_destroy])
  end
  
  def check_params
    params.permit(checklists: [:check])[:checklists]
  end
  
  # beforeフィルター
  
  def set_plan
   # @plan = Plan.find(params[:user_id])
    @plan = Plan.find(params[:id])
  end
end
