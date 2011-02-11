module ApplicationHelper
  def nav_link(text, controller, action="index")
    link_to_unless_current( text, :controller => controller, 
                                 :action => action)
  end
  
  def truncate_body(post)
    text = truncate(strip_tags(post.body), :length => 200)
    return text.to_s.gsub(/&nbsp;/, '')
  end
  def find_img(post)
    doc = Hpricot(post.body)
    final = doc.search("img[@style]").remove_attr("style").first
    if final != nil
      return final.to_html.html_safe
    end
  end
  
  def user_thumb(user)
    image_tag user.avatar.url(:thumb)
  end
  
  def logged_in?
    !!current_user
  end
  
  def access_denied
    redirect_to new_session_path
    respond_to do |format|
      format.html do
        redirect_to new_session_path
      end
    end
  end
end
