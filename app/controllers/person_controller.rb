class PersonController < ApplicationController

  before_filter :require_person

  def show
    redirect_to :root unless authenticated?
  end

end
