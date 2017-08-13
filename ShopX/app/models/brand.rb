class Brand < ActiveRecord::Base
	validates :sName, presence: true
end
