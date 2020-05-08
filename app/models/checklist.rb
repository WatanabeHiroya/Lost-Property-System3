class Checklist < ApplicationRecord
  belongs_to :user
  
  validates :object, presence: true
  validates :departure_time, presence: true
  
  # 未来の日時を指定
  validates :departure_time_must_be_later_than_current_date
  
  def departure_time_must_be_later_than_current_date
    errors.add(:departure_time, "現在日時より後の日時を指定して下さい。") if departure_time < Time.now
  end
end
