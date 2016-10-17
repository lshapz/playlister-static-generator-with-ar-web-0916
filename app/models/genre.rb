class Genre < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  
  has_many :songs
  has_many :artists, through: :songs
def to_slug
self.name.downcase.gsub(" ", "-")end 

end
