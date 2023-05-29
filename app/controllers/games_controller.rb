require 'json'
require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  # Needed to update this to account for vowels
  # def new
  #   @letters = ('a'..'z').to_a.sample(10)
  # end

  def score
    @grid = params[:grid].split
    @word = params[:word || ""].upcase
    @english_word = word_check(@word)
    @included = grid_check(@word, @grid)
  end

  private

  # check if word is English
  def word_check(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    @word_serialized = URI.open(url).read
    @word_check = JSON.parse(@word_serialized)
    return @word_check['found']
  end

  # check if word is in grid
  def grid_check(word, grid)
    @word = word
    @word.chars.all? do |letter|
      @word.count(letter) <= @grid.count(letter)
    end
  end
end
