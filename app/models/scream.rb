class Scream < ActiveRecord::Base
	def self.all_screams
		Scream.find(:all,:limit => 10, :order => 'id DESC')	
	end
end
