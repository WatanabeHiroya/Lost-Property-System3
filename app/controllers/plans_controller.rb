class PlansController < ApplicationController
  
  def new
   # @user = User.find(params[:id])
    @plan = Plan.new
  end
  
  def create
    @user = User.find(params[:id])
    @plan = Plan.new(plan_params)
    @plan.user_id = @user.id # user.idがnilでエラーとなるため
    if @plan.save
      flash[:success] = "チェックリストを作成しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    @checklists = Checklist.where(plan_id: params[:id])
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  
  private
  
  def plan_params
    params.require(:plan).permit(:subject, :departure_at, checklists_attributes: [:id, :plan_id, :item, :check, :_destroy])
  end
end
