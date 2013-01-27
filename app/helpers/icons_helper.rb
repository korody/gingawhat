module IconsHelper
  def icon_link_to(title, icon, *args)
    link_to "#{icon_tag icon} #{title}".html_safe, *args
  end

  def icon_tag(icon, title = nil)
    "<i class='icon-#{icon}' title='#{title}'></i>".html_safe
  end
end