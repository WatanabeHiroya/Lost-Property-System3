class LostPropertyMailer < ApplicationMailer
  def send_mail(plan)
    @plan = plan
    
    @no_check_items = []
    @plan.checklists.each do |c|
      @no_check_items << c.item if c.check == "0" # c[:check]
    end
    
    mail(
      from: 'plastic.gu@gmail.com',
      to:   'plastic.gu@gmail.com',
      subject: '出発予定時間です'
      )
  end
end
