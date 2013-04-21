module IconsHelper
  def icon_link_to(icon, target, *args)
    link_to "#{icon_tag icon}".html_safe, target, *args
  end

  def icon_tag(icon, title = nil)
    "<i class='icon-#{icon}' title='#{title}'></i>".html_safe
  end
end