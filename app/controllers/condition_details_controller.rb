class ConditionDetailsController < ApplicationController
  def index
    respond_to do |format|
      format.js do
        if params[:condition_id].present? && params[:params_name].present?
          @condition = Condition.find params[:condition_id]
          @condition_details = @condition.condition_details
          @params_name = params[:params_name]
        end
      end
    end
  end
end
