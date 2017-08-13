class Product < ActiveRecord::Base
  belongs_to :brand
  validates :Name, presence: true
  validates :Price, presence: true, :numericality => {:only_decimal => true, :message => "Only Number"}, :inclusion =>1..100

end
