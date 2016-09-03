class User < ApplicationRecord
  include Omniauthable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]


  has_many :stories, dependent: :destroy

  validates :username, presence: true
  validate :avatar_image_size

  mount_uploader :avatar, AvatarUploader

  def avatar_image_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
