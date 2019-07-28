# This class is used to keep common functions.
class CommonHelper
  class << self

  #This function is used to scroll to view the element. 
  def scroll_to(element)
    script = <<-JS
		  arguments[0].scrollIntoView(true);
		JS
    page.execute_script(script, element.native)
  end
  end
end
