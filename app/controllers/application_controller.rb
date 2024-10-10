class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    # Use the locale from params if present, or default to checking the browser's language
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    # Map browser's language to available locales
    case browser_locale
    when 'en' then :en
    when 'fr' then :fr
    when 'es' then :es
    when 'ca' then :ca
    else
      :en # Default to English if the browser language is not supported
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
