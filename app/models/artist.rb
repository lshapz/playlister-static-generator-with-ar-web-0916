class Artist < ActiveRecord::Base
  include Slugifiable::InstanceMethods

  has_many :songs
  has_many :genres, through: :songs

def to_slug
self.name.downcase.gsub(" ", "-")
end 

end
