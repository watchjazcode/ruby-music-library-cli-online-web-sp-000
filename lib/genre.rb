require_relative "./findable.rb"

class Genre 
  
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
  
  def artists
    collected_artists = []
    songs.each do |song|
      collected_artists << song.artist
    end
    return collected_artists.uniq
  end
  
  def self.destroy_all
    @@all = [] 
  end
  
  def self.create(genre_name)
    new_genre = new(genre_name)
    new_genre.save
    return new_genre
  end
  
  def add_song(song)
    if song.genre == nil 
      song.set_genre(self)
    end
    if !@songs.include? song
      @songs << song
    end
  end

  
end 