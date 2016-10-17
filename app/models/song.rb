class Song < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  
  belongs_to :artist
  belongs_to :genre
def to_slug
  self.name.downcase.gsub(" ", "-")
end 

end
