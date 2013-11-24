class Order < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images
  validates_associated :images

  after_create :send_new_order_mail
#  after_update :save_images

#  def new_image_attributes=(image_attributes)
#    image_attributes.each do |attributes|
#      images.build(attributes)
#    end
#  end

#  def existing_image_attributes=(image_attributes)
#    images.reject(&:new_record?).each do |image|
#      attributes = image_attributes[image.id.to_s]
#      if attributes
#        image.attributes = attributes
#      else
#        image.delete(image)
#      end
#    end
#  end 

#  def save_images
#    images.each do |image|
#      image.save(false)
#    end
#  end

  private
  def send_new_order_mail
  	OrderMailer.new_order(self).deliver
  end
end
