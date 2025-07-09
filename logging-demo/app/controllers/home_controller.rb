class HomeController < ApplicationController


  def index
    logger.debug "This is a debug message"
    logger.info "This is an info message"
    logger.warn "This is a warning message"
    logger.error "This is an error message"
    logger.fatal "This is a fatal message"
    render "index"
  end
end
 