class Idol < ApplicationRecord
  include WithUuid

  belongs_to :group

  validates :name, :group_id, presence: true

  scope :ordered, -> { order(:name) }

  def to_s
    "#{group} #{name}"
  end
end
