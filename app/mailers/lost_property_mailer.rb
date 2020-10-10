class LostPropertyMailer < ApplicationMailer
  
  def send_mail(plan)
    @no_check_items = []
    plan.checklists.each do |c|
      @no_check_items << c.item if c.check == "0"
    end
    
    @user = User.find(plan.user_id)
    mail(
      from: 'lost.property.system@gmail.com',
      to:   @user.email, # 任意のユーザーのアドレス
      subject: "#{plan.subject}の出発予定時間のご連絡"
      )
  end

  def prior_send_mail(plan)
    @no_check_items = []
    plan.checklists.each do |c|
      @no_check_items << c.item if c.check == "0"
    end
    
    @user = User.find(plan.user_id)
    mail(
      from: 'lost.property.system@gmail.com',
      to:   @user.email, # 任意のユーザーのアドレス
      subject: "#{plan.subject}の出発予定時間が近くなりました"
      )
  end  
  
end
