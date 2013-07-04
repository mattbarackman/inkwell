module SpecHelpers
  def datetime_rand from = Time.now, to = Time.now + 6.months
    Time.at(from + rand * (to.to_f - from.to_f))
  end
end