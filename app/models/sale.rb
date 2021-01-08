class Sale < ActiveRecord::Base

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
