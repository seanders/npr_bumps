class ShowController < ApplicationController

  def show
    @collection = Show.all
    @collection = filter!(@collection)
  end
end
