class Customer < ApplicationRecord
  validates_presence_of :name, :email, :phone, :smoker, :avatar  
end
