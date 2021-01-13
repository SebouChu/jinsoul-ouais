module WithUuid
  extend ActiveSupport::Concern

  included do
    before_validation :generate_uuid, on: :create
  end

  def to_param
    uuid
  end

  protected

  def generate_uuid
    loop do
      self.uuid = SecureRandom.uuid
      break unless self.class.unscoped.where(uuid: uuid).exists?
    end
  end
end
