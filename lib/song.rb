require_relative "./findable.rb"

class Song 
  
  attr_accessor :name, :artist, :genre
  
  extend Concerns::Findable
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
  end
  
  def set_artist(artist)
    @artist = artist
  end
  
  def set_genre(genre)
    @genre = genre
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all = [] 
  end
  
  def self.create(song_name)
    new_song = new(song_name)
    new_song.save
    return new_song
  end
  
  def artist=(given_artist)
    given_artist.add_song(self)
  end
  
  def genre=(given_genre)
    given_genre.add_song(self)
  end
  
  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name
    end
  end
  
  def self.new_from_filename(filename)
    artist_name = filename.split(" - ")[0]
    name = filename.split(" - ")[1]
    genre = filename.split(" - ")[2].gsub(".mp3", "")
    song = self.new(name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre)
    song
  end
  
  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
    return song
  end

  
end 

