class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:discord]

  def to_s
    email
  end

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_initialize do |user|
      user.discord_uid = auth.uid
      user.password = "#{Devise.friendly_token[0, 20]}!"
    end
    user.from_discord = true
    user.save
    user
  end
end
