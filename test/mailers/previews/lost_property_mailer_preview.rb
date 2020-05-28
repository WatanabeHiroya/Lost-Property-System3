# Preview all emails at http://localhost:3000/rails/mailers/lost_property_mailer
class LostPropertyMailerPreview < ActionMailer::Preview
  def plan
    plan = Plan.new(user_id: 2, subject: "テストメール", departure_at: DateTime.now)

   # checklists = Checklist.new(plan_id: 1, item: "持ち物1", check: "0")
    
    LostPropertyMailer.send_mail(plan)
  end

end
