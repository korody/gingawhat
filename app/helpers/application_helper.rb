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

  def active_city?(city_id)
   "active" if city?(city_id)
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.first(22).each do |tag|
      index = tag.count.to_f / max.count.to_i * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def paginate_with(collection)
    will_paginate(collection, renderer: BootstrapPagination::Rails)
  end

  private

    def controller?(*controller)
      controller.include?(params[:controller])
    end

    def action?(*action)
      action.include?(params[:action])
    end

    def city?(city_id)
      city_id == @city.id if params[:city]
    end
end