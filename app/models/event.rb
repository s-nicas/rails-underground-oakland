class Event < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :cost, presence: true
  validates :description, presence: true

end
