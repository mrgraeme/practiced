module ApplicationHelper

  def title
    base_title = "Practiced"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    logo = image_tag("logo.png", :alt => "Practiced", :class => "round")
  end
  
end
