class Group < ApplicationRecord
  include WithUuid

  has_many :idols

  validates :name, presence: true

  scope :ordered, -> { order(:name) }

  def to_s
    name
  end
end
