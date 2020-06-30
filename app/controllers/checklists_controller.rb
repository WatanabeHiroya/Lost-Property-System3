class ChecklistsController < ApplicationController
  
  def new
  end
  
  def create
  end
  
  def show
    
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    # checklistの特定がしたい
    @checklist = Checklist.find(params[:id])
    @plan = Plan.find(@checklist.plan_id)
    @checklist.destroy
    redirect_to edit_user_plan_url(@plan.user_id, @plan)
  end
  
  
  private
  
  
end
