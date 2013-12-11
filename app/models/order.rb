class Order < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images
  
  validates_associated :images
  validates :email, presence: true, email: true

  before_create :generate_security_key
  after_create :send_new_order_mail

  private
  def send_new_order_mail
  	OrderMailer.new_order(self).deliver
  end

  def generate_security_key
  	self.security_key = rand(100000..999999)
  end
end
