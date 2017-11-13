module ApplicationHelper
  
  def log_in
    session[:logged_in] = true
  end

  def log_out
    session.delete(:logged_in)
    @logged_in = nil
  end

  def logged_in
    @logged_in ||= session[:logged_in]
  end

  def logged_in?
    logged_in.present?
  end

  def present(model, presenter_class=nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end

  def h
    ApplicationController.helpers
  end
end
