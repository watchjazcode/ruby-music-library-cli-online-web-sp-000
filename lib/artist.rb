require_relative "./findable.rb"

class Artist 

  attr_accessor :name, :songs
  
  extend Concerns::Findable
  
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def songs 
    return @songs
  end

  def add_song(song)
    if song.artist == nil 
      song.set_artist(self)
    end
    if !@songs.include? song
      @songs << song
    end
  end
  
  def genres 
    collected_genres = []
    songs.each do |song|
      collected_genres << song.genre
    end
    return collected_genres.uniq
  end
  
  def self.destroy_all
    @@all = [] 
  end
  
  def self.create(artist_name)
    new_artist = new(artist_name)
    new_artist.save
    return new_artist
  end
  
end