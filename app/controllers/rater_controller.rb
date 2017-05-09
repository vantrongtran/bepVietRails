class RaterController < ApplicationController

  def create
    if user_signed_in?
      obj = params[:klass].classify.constantize.find(params[:id])
      obj.rate params[:score].to_f, current_user, params[:dimension]
      render :json => {success: true, result: "(#{obj.average&.avg || obj.rates.first.stars || 0.0}/#{obj.rates.count})"}
    else
      render :json => {success: false}
    end
  end
end
