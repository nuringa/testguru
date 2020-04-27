module FlashHelper
  def display_flash
    render 'shared/flash', messages: flash
  end
end