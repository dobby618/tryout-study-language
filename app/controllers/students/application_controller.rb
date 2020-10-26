# frozen_string_literal: true

module Students
  class ApplicationController < ApplicationController
    before_action :authenticate_student!
  end
end
