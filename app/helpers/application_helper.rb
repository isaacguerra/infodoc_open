# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def f_data(d)
      "#{d.to_s[8..9]}/#{d.to_s[5..6]}/#{d.to_s[0..3]}"
  end
end
