class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = './db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end 
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets
    while input != "exit"
      input = gets 
      if input == 'list songs'
        list_songs
      end
    end
  end
  
  def list_songs
    Song.all.sort_by {|song| song.name }.each_with_index do |song, index| 
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" 
    end
  end
  
  def list_artists
    Artist.all.sort_by {|artist| artist.name }.each_with_index do |artist, index| 
      puts "#{index + 1}. #{artist.name}" 
    end
  end
  
  def list_genres
    Genre.all.sort_by {|genre| genre.name }.each_with_index do |genre, index| 
      puts "#{index + 1}. #{genre.name}" 
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    found_artist = Artist.find_by_name(input)
    if found_artist == nil
      return nil
    end
    found_artist.songs.sort_by {|song| song.name }.each_with_index do |song, index| 
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"  
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    found_genre = Genre.find_by_name(input)
    if found_genre == nil
      return nil
    end
    found_genre.songs.sort_by {|song| song.name }.each_with_index do |song, index| 
      puts "#{index + 1}. #{song.artist.name} - #{song.name}"  
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets
    sorted_songs = Song.all.sort_by {|song| song.name } 
    if !(1..sorted_songs.length).include?(input.to_i)
      return nil
    end
    song = sorted_songs[input.to_i - 1]
    if song == nil 
      return nil
    end
    puts "Playing #{song.name} by #{song.artist.name}"
  end
  
end