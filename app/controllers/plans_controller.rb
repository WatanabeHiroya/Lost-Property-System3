class PlansController < ApplicationController
  
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
    @checklists = Checklist.where(plan_id: params[:id])
  end
  
  def edit
    @plan = Plan.find(params[:id])
  end
  
  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(plan_params) # フォーム追加したものだけが飛んできている
      flash[:success] = "チェックリストを更新しました。"
      redirect_to current_user
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  
  private
  
  def plan_params
    params.require(:plan).permit(:subject, :departure_at, checklists_attributes: [:id, :plan_id, :item, :check, :_destroy])
  end
end
