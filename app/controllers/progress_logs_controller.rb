class ProgressLogsController < ApplicationController
  before_action :set_progress_log, only: [ :show ]
  def index
    @logs = ProgressLog.all
  end

  def show
  end

  private
  def set_progress_log
    @log = ProgressLog.find(params[:id])
  end
end
