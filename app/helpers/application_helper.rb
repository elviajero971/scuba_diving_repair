module ApplicationHelper
  def i18n_js
    translations = I18n.t('user_gears') # Only load translations for user gears
    javascript_tag "window.I18n = #{translations.to_json};"
  end
end
