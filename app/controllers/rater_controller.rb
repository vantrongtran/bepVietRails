class RaterController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :edit]

  def create
    if user_signed_in? || params[:score].to_f < 5.0
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]
      render :json => {success: true, result: "(#{obj.average&.avg || obj.rates.first.stars || 0.0}/#{obj.rates.count})"}
    else
      render :json => {success: false}
    end
  end
end
