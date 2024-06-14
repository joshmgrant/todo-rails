class RandosController < ApplicationController
  def index
    randos = Array.new(10) { |i| Random.rand } 
    render json: randos
  end
end
