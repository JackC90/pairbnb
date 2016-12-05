class User < ApplicationRecord
  include Clearance::User
  validates :email, presence: true, uniqueness: true, format: { with: /.+@.+/, message: "wrong format" }
  validates :password, presence: true
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  mount_uploaders :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.password = Time.now.to_i.to_s(36)
      u.name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  enum role: [:guest, :host, :admin]
end
