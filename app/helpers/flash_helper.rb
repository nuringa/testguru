module FlashHelper
  def display_flash
    flash.map do |type, message|
      content_tag :p, class: "flash #{type}" do
        message
      end
    end.join.html_safe
  end
end
