class ConfigVariables < ActiveRecord::Base
  attr_accessible :key, :value

  def self.[](k)
    where(key: k).first.try(:value)
  end

  def self.[]=(k, v)
    row = where(key: k).first_or_create(value: v)
    return v if row.value == v
    update_all({value: v}, {key: k})
    v
  end
end
