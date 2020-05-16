class CreateChecklists < ActiveRecord::Migration[5.1]
  def change
    create_table :checklists do |t|
      t.string :item
      t.string :check
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
