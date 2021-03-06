class Slot < ActiveRecord::Base
  attr_accessible :day, :program_id, :time

  validates_numericality_of :day, greater_than_or_equal_to: 0
  validates_numericality_of :time, greater_than_or_equal_to: 0, less_than_or_equal_to: 11
  validates_uniqueness_of :time, scope: [:company_id, :day]
  validate :creation_time_validation, on: :create

  belongs_to :company
  belongs_to :ad_contract
  belongs_to :program

  def pay!
    return unless audience && ad_contract
    company.money += ((ad_contract.price / 1000.0) * audience).round
    company.save!
  end

  private

  def creation_time_validation
    return unless day && time # This is just to prevent nil errors, another
                              # validation will take care of the value.
    return if day > ConfigVariables[:day].to_i && day <= (ConfigVariables[:day].to_i + 2)
    return if day == ConfigVariables[:day].to_i && time > ConfigVariables[:time].to_i
    errors.add(:time, "Should be a future time")
  end
end
