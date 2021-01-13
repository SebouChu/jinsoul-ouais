class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:discord]

  enum role: { visitor: 0, admin: 50 }

  validates_presence_of :email
  validates_uniqueness_of :email, allow_blank: true, if: :will_save_change_to_email?
  validates_format_of :email, with: Devise::email_regexp, allow_blank: true, if: :will_save_change_to_email?
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validate :password_complexity

  before_validation :generate_uuid, on: :create

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_initialize do |user|
      user.password = "#{Devise.friendly_token[0, 20]}!"
    end
    user.discord_uid = auth.uid
    user.from_discord = true
    user.save
    user
  end

  def to_s
    email
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

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!,@$%^&*\-+£µ]).{8,70}$/
    errors.add :password, 'complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end
end
