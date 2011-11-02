
class Video < ActiveRecord::Base
  validates_presence_of         :name
  validates_presence_of         :video_id
  belongs_to :user
  
  def self.search(search)
    if search
      where('video_id LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def self.save(upload)
    #name =  upload['datafile'].original_filename
    path = "public/images/mikko.jpg"
    # create the file path
    #path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
  

end