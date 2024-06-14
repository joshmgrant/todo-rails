class RandoController < ApplicationController
  def index
    rando = Random.rand
    render json: rando
  end

  def to_list
    
  end
end
