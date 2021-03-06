module ApplicationHelper
  def nav_link(text, controller, action="index")
    link_to_unless_current( text, :controller => controller, 
                                 :action => action)
  end
  
  def truncate_body(post)
    text = truncate(strip_tags(simple_format(post.body)), :length => 70)
    return text.to_s.gsub(/&nbsp;/, '')
  end
  
  def find_img_medium(post)
    if post.use_uploaded_image == 1
      if post.photo != nil
        post.photo_url(:medium).to_s
      else
        '/images/missing.jpg'
      end
    elsif post.use_uploaded_image == 0
      if post.imagebank != nil
        post.imagebank.image_url(:medium).to_s
      else
        '/images/missing.jpg'
      end
    else
      '/images/missing.jpg'
    end
  end
  
  def find_img_medium_deal(deal)
    if deal.photo_url != nil
      deal.photo_url(:medium).to_s
    else
      '/images/missing.jpg'
    end
  end
  
  def find_img_thumb_user(user)
    if user.avatar_url != nil
      user.avatar_url(:thumb).to_s
    else
      if user.spec != nil
        if user.spec.gender != nil
          if user.spec.gender == "Mies"
            '/images/layout/male.gif'
          elsif user.spec.gender == "Nainen"
            '/images/layout/female.gif'
          else
            '/images/missing.jpg'
          end
          '/images/missing.jpg'
        end
        '/images/missing.jpg'
      end
      '/images/missing.jpg'
    end
  end
  
  def find_img_medium_user(user)
    if user.avatar_url != nil
      user.avatar_url.to_s
    else
      if user.spec.gender != nil
        if user.spec.gender == "Mies"
          '/images/layout/male.gif'
        elsif user.spec.gender == "Nainen"
          '/images/layout/female.gif'
        else
          '/images/missing.jpg'
        end
      end
    end
  end
  
  def find_img_thumb(post)
    if post.use_uploaded_image != nil
      if post.use_uploaded_image == 1
        post.photo_url(:thumb).to_s
      elsif post.use_uploaded_image == 0
        if post.imagebank_id != nil
          post.imagebank.image_url(:thumb).to_s
        else
          '/images/missing.jpg'
        end
      else
        '/images/missing.jpg'
      end
    else
      '/images/missing.jpg'
    end
  end
  
  def find_img(post)
    if post.use_uploaded_image == 1
      post.photo_url.to_s
    elsif post.use_uploaded_image == 0
      post.imagebank.image_url.to_s
    else
      '/images/missing.jpg'
    end
  end
  
  def user_thumb(user)
    image_tag user.avatar_url(:thumb).to_s
  end
  
  def logged_in?
    !!current_user
  end
  
  def display_youtube_videos(_videos)
    if !_videos.blank?
      html = ""
      #html += "<div id='videoplay'>"
      #html += "<object width=\"385\" height=\"344\"><param name=\"movie\" value=\"http://www.youtube.com/v/"+_videos.first.video_id+"\"</param><param name=\"allowFullScreen\" value=\"true\"></param><embed src=\"http://www.youtube.com/v/"+_videos.first.video_id+"\" type=\"application/x-shockwave-flash\"  allowfullscreen=\"true\"  width=\"385\" height=\"344\"></embed></object>"
      html +="<div><ul id=\"youtubelist\" class=\"mediaList\">"
      _videos.each do |v|
        html += "<li onclick=\"display_video_player('http://www.youtube.com/v/#{v.video_id}');\"> videooor"+"</li>" #image_tag(v.thumbnails.first.url)+
      end
      html += "</ul></div>"
    else
      html = "<div id='emptyYoutube'>No related videos were found</div>"
    end
      return html
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
