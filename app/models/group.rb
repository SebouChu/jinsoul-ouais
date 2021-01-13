class Group < ApplicationRecord
  include WithUuid

  def to_s
    name
  end
end
