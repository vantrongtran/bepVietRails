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
      format.json do
        conditions = Condition.all
        condition = params[:condition_id].present? ? Condition.find(params[:condition_id]) : Condition.first
        condition_details = condition&.condition_details
        render json: {conditions: conditions.to_json, condition: condition.to_json, condition_details: condition_details.to_json}
      end
    end
  end
end
