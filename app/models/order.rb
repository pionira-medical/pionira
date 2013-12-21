class Order < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images

  validates :hospital, :department, :street_1, :zip, :city, :email, presence: true
  validates_associated :images

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
