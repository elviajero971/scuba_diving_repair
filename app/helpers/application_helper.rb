module ApplicationHelper
  def i18n_js
    translations = I18n.t('user_gears') # Only load translations for user gears
    javascript_tag "window.I18n = #{translations.to_json};"
  end

  def translate_enum(model, attribute, model_class = nil)
    # Use the provided model_class if model is not an ActiveRecord model
    klass = model_class || model.class
    value = model.public_send(attribute)
    I18n.t("activerecord.attributes.#{klass.model_name.i18n_key}.#{attribute}.#{value}")
  end
end
