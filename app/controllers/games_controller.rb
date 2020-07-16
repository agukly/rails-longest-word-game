require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase
    if !compsrison?(@word.split(''), @letters.split)
      @result = "Sorry, but #{@word} can't be build out of #{@letters}"
    elsif !check_api?(@word)
      @result = "Sorry, but #{@word} doesn't seem to be valid English word..."
    else
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end

  def check_api?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    word["found"]
  end

  def compsrison?(word, letters)
    word.each do |letter|
      if letters.count(letter) == 0
        return false
      elsif word.count(letter) < letters.count(letter)
        return false
      end
    end
    return true
 end


end

