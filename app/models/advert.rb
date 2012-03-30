class Advert < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  # Attach image (by paperclip)
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "/system/images/default_image.jpg", :default_style => :thumb
end
