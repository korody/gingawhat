module ApplicationHelper
  def full_title(page_title)
    base_title = "ginga what?"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def active?(controller, action)
    "active" if controller?(controller) && action?(action)
  end

  private

    def controller?(*controller)
      controller.include?(params[:controller])
    end

    def action?(*action)
      action.include?(params[:action])
    end
end
