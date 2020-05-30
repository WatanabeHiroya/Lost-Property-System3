class LostPropertyMailer < ApplicationMailer
  def send_mail(plan)
    plan.update_attributes(:sent, "1")
    @no_check_items = []
    plan.checklists.each do |c|
      @no_check_items << c.item if c.check == "0"
    end
    
    mail(
      from: 'lost.property.system@gmail.com',
      to:   'lost.property.system@gmail.com', # 任意のユーザーのアドレス
      subject: '出発予定時間のご連絡'
      )
  end
end
