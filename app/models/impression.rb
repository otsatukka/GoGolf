class Impression < ActiveRecord::Base
  belongs_to :impressionable, :polymorphic=>true
  
  def self.top5(type, start_date=nil, end_date=nil)
    res = start_date.blank? ? where(:impressionable_type => type).find(:all, :select => "impressionable_id, count(impressionable_id) as frequency",
                      :limit => 5,
                      :conditions => "impressionable_id is not null",
                      :group => "impressionable_id",
                      :order => "frequency desc") :
                      where("created_at>=? and created_at<=? and impressionable_type=?", start_date, end_date, type).find(:all, :select => "impressionable_id, count(impressionable_id) as frequency",
                                        :limit => 5,
                                        :conditions => "impressionable_id is not null",
                                        :group => "impressionable_id",
                                        :order => "frequency desc")
                      res.collect!{|r| r.impressionable_id}
                      
                  end
end