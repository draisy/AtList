class RootsController < ApplicationController
  layout "special"

  def index
    if current_user
      redirect_to main_path
    end
  end

  def main
  end

  def team
  end

  def what_we_do
  end

  def contact
  end

end
