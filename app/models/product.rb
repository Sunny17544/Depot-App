class Product < ApplicationRecord
    validates :name, presence: true
    validates :model, presence: true
    validates :colour, presence: true
    #validates :camera, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
    validates :image, presence: true
    has_one_attached :image
end
