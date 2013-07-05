module ApplicationHelper

  def format_price(price)
    "$"+(price/100).to_s+"."+(price%100).to_s
  end

end
