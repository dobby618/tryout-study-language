# frozen_string_literal: true

module Teachers
  class ApplicationController < ApplicationController
    before_action :authenticate_teacher!
  end
end
