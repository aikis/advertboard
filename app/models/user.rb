class User < ActiveRecord::Base
  has_many :adverts, :dependent => :delete_all
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :full_name, :birthday, :address, :city, :state, :country, :zip, :email, :password, :password_confirmation, :remember_me,  :latitude, :longitude, :gmaps

  # Validate all fields are not empty
  validates :login, :full_name, :birthday, :address, :city, :state, :country, :zip, :presence => true

  # Roles [Cancan]
  ROLES = %w[admin moderator user]

  # Gmaps location
  acts_as_gmappable :check_process => false, :validation => false

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.city}, #{self.country}" 
  end

  # Omniauth use
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.new(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end
  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    login = access_token.extra.raw_info['nickname'] if access_token.extra.raw_info
    if user = User.find_by_login(login)
        user
    else
      User.create(:login => login, :password => Devise.friendly_token[0,20])
    end
  end
end
