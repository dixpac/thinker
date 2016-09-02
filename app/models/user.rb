class User < ApplicationRecord
  include Omniauthable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]


  has_many :stories, dependent: :destroy

  validates :username, presence: true
end
