require 'open-uri'

class Recipe < ActiveRecord::Base
  validates :page, numericality: { only_integer: true }

  def self.set_of_recipes(page, dish, ingredients)
    search = "?i=#{ingredients}&q=#{dish}&p=#{page}"
    RecipePuppy(search)
    @recipe_hash["results"]
  end

  def self.RecipePuppy(search)
    uri = 'http://www.recipepuppy.com/api/'
    @url = "#{uri}#{search}"

    @api_json = open(@url, :read_timeout => 10).read
    @recipe_hash = JSON.parse(@api_json)
  end
end
