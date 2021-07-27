require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

   def score
    @letters = params[:letters]
    @word = params[:new]
    @include = include?(@word, @letters)
    @call_api = call_api?(@word)
  end

  def include?(word, letters)
    word.chars.all?{ |letter| word.count(letter) <= letters.count(letter) }
  end

  def call_api?(word)
    data = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    resultados = JSON.parse(data.read)
  end
end

private

def generate_grid(nro)
  (0..nro).map {('A'..'Z').to_a.sample}
end

