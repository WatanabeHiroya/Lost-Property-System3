class AddSendMailToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :send_mail, :string, default: "0"
  end
end
