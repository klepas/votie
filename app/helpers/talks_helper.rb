module TalksHelper
  # Returns link text for a slide type
  def slide_type_text(slide_type)
    slide_type_text = {'pdf' => "View PDF slides",
                       'slideshare' => "View slides on SlideShare",
                       'other' => "More info"}

    slide_type_text[slide_type]
  end
end
