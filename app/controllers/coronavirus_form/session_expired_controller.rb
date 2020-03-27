# frozen_string_literal: true

class CoronavirusForm::SessionExpiredController < ApplicationController
  skip_before_action :check_first_question

  def show
    render "coronavirus_form/session_expired"
  end
end
