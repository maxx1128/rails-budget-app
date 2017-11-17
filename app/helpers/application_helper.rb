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

  def random_finance_quote
    quotes = [
      "Balancing your money is the key to having enough.",
      "Every time you borrow money, you're robbing your future self.",
      "When you work on something that only has the capacity to make you 5 dollars, it does not matter how much harder you work – the most you will make is 5 dollars.",
      "Money, like emotions, is something you must control to keep your life on the right track.",
      "There is only one way to make money: sell something. You're either selling your time or a product. The secret? Productize your time. That's freedom.",
      "Money per se does not make you happy - it's what it enables you to do with your life.",
      "Chase after money and the stuggering race will never end; but reach out for successful ideas and the sources of money will chase after you to fill your pockets.",
      "Money does not dictate your lifestyle, it's what you do to get it and how you manage your finances that determines your lifestyle.",
      "Budgeting has only one rule: Do not go over budget."
    ]

    "\"#{quotes.sample}\""
  end

  def h
    ApplicationController.helpers
  end
end
