class Sale < ActiveRecord::Base

  # AR scope, class method
  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    #starts_on == self.starts_on
    starts_on > Date.current
  end

  def active?
    #return is implicit
    !upcoming? && !finished?
  end

end
