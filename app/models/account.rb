class Account < ActiveRecord::Base
  belongs_to  :user
  has_many    :transactions, dependent: :destroy
  validates   :title, presence: true
  validates   :login, uniqueness: true
  validates   :login, presence: true, length: { is: 16 }

  before_validation :generate_login


  def initialize(attributes = {})
    super
    self.login = generate_login
  end

  # def self.logins
  #   all.map{ |account| account.login }
  # end

  def generate_login
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    self.login = (0...16).map { o[rand(o.length)] }.join
  end

end
