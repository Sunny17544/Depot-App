class Payment < ApplicationRecord
  belongs_to :checkout
  validates :chargeid, :status, :amount, presence: true
end
