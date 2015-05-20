class TagsController < BaseController
  skip_before_action :reset_tag_ids
  
  def mark
    session[:tag_ids] = [] if session[:tag_ids].nil?
    tag_id            = params[:id].to_i
    
    if session[:tag_ids].include?(tag_id)
      session[:tag_ids].delete(tag_id)
    else
      session[:tag_ids].push tag_id
    end
  
    redirect_to articles_url
  end
end
