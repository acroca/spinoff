class Company < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :programs

  validates_presence_of :name
  validates_numericality_of :money

  def buy(program)
    return false unless program.available?
    program.available = false
    program.save
    self.programs << program
    true
  end
end
