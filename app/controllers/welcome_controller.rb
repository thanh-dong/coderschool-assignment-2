class WelcomeController < ApplicationController
  before_action :skipped_if_login, only: [:index]

  def index
  end
end
