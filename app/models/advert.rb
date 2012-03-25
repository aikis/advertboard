class Advert < ActiveRecord::Base
  belongs_to :user

  # Attach image (by paperclip)
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "/system/images/default_image.jpg", :default_style => :thumb

  # Using Sunspot search engine
  searchable do
    text :text
    text :user, :search_items
    time :updated_at
  end

  def search_items
    "#{user.full_name}, #{user.address}"
  end
end
