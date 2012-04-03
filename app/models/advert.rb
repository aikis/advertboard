class Advert < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  # Attach image (by paperclip)
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "/system/images/default_image.jpg", :default_style => :thumb
  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }

  def thumb_text
    if self.text.size > 160
      thumb = self.text[0..159]
      thumb = thumb[0..(thumb.rindex(/\W/)-1)] + "..."
    else
      self.text
    end
  end
end
