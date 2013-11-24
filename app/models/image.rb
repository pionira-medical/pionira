class Image < ActiveRecord::Base
  belongs_to :order
  has_attached_file :file, :styles => { :thumb => "100x100>" }
end
