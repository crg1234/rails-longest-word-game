require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @grid = params[:grid]
    @word = params[:word]
    @valid = word_check(@word)
    @word_in_grid = grid_check(@word, @grid)
  end

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
