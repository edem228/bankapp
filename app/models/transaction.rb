class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  validates   :title, :amount, :outgoing, presence: true
end
