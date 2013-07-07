module ApplicationHelper

  def format_price(price)
    cents = (price % 100 == 0) ? "00" : (price % 100).to_s
    "$"+(price/100).to_s+"."+cents
  end

  def format_date(date)
    date.strftime("%A %B %e, %Y")
  end

end
