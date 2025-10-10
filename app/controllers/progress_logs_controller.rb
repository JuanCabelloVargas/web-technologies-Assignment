class ProgressLogsController < ApplicationController
  def index
    @logs = ProgressLog.all
  end

  def show
    @log = ProgressLog.find(params[:id])
  end
end
