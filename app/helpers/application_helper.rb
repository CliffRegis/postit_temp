module ApplicationHelper

  def display_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

end
