module ApplicationHelper
  def nav_link_to(text, url, options = {})
    options[:class] ||= ""
    options[:class] += " active" if current_page?(url)
    options[:class].strip!
    link_to text, url, options
  end
end
