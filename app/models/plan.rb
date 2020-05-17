class Plan < ApplicationRecord
  belongs_to :user
  has_many :checklists, dependent: :destroy
  accepts_nested_attributes_for :checklists, allow_destroy: true 
  
  validates :subject, presence: true
  validates :departure_at, presence: true
  
  # 未来の日時を指定
  validate :departure_at_must_be_later_than_current_date
  
  def departure_at_must_be_later_than_current_date
    errors.add(:departure_at, "は現在日時より後の日時を指定して下さい。") if departure_at < Time.now
  end

end
