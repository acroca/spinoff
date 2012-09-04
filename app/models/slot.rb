class Slot < ActiveRecord::Base
  attr_accessible :day, :program_id, :time

  validates_numericality_of :day, greater_than_or_equal_to: 0
  validates_numericality_of :time, greater_than_or_equal_to: 0, less_than_or_equal_to: 11
  validates_uniqueness_of :time, scope: [:company_id, :day]

end
