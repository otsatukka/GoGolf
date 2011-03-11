class Autolink < ActiveRecord::Base
  belongs_to :link
  
  auto_html_for :linkurl do
    html_escape
    sized_image
    youtube(:width => 480, :height => 390)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
  
end