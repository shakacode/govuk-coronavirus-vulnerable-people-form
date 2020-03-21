# frozen_string_literal: true

require "spec_helper"

RSpec.describe CoronavirusForm::NhsLetterController, type: :controller do
  let(:current_template) { "coronavirus_form/nhs_letter" }
  let(:session_key) { :nhs_letter }

  describe "GET show" do
    it "renders the form" do
      get :show
      expect(response).to render_template(current_template)
    end
  end

  describe "POST submit" do
    let(:selected) { permitted_values.sample }
    let(:permitted_values) do
      I18n.t("coronavirus_form.nhs_letter.options").map { |_, item| item[:label] }
    end

    it "sets session variables" do
      post :submit, params: { nhs_letter: selected }
      expect(session[session_key]).to eq selected
    end

    it "validates any option is chosen" do
      post :submit, params: { nhs_letter: "" }

      expect(response).to render_template(current_template)
    end

    it "redirects to next step for a permitted response" do
      post :submit, params: { nhs_letter: selected }
      expect(response).to redirect_to(coronavirus_form_check_your_answers_path)
    end

    it "validates a valid option is chosen" do
      post :submit, params: { nhs_letter: "<script></script>" }

      expect(response).to render_template(current_template)
    end
  end
end