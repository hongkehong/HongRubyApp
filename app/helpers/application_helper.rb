# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def logo
    image_tag("rails.png", :alt => "HKH App", :class => "round")
  end

end
