class Company < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :programs
  has_many :ad_contracts
  has_many :slots

  validates_presence_of :name
  validates_numericality_of :money
  validates_uniqueness_of :user_id

  def buy(program)
    return false unless program.available?
    program.available = false
    program.company = self
    program.save!
    self.money -= program.price
    self.save!
    self.programs << program
    Pusher["spinoff"].trigger 'program-bought', program.id
    true
  end

  def sign(ad_contract)
    return false unless ad_contract.available?
    ad_contract.company = self
    ad_contract.save!
    self.ad_contracts << ad_contract
    Pusher["spinoff"].trigger 'ad-contract-signed', ad_contract.id
    true
  end
end
