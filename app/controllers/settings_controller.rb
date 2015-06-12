class SettingsController < ApplicationController

  #PUT
  def switch_language
    if current_lang.to_sym == :ru
      set_language(:en)
    else
     set_language(:ru)
    end
    
    redirect_to root_path
  end
end

