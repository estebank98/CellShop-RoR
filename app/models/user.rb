class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    include PermissionsConcern

    has_one :cart
    has_many :order

    def avatar
    	# get the email from URL-parameters or what have you and make lowercase
		email_address = self.email.downcase
		 
		# create the md5 hash
		hash = Digest::MD5.hexdigest(email_address)
		 
		# compile URL which can be used in <img src="RIGHT_HERE"...
		image_src = "https://www.gravatar.com/avatar/#{hash}"
    end
    

    
end
