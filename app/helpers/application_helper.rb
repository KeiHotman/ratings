module ApplicationHelper
  def departments_locales_with_key
    Constants::DEPARTMENTS.keys.map{|k| [t("constant.departments.#{k}"), k]}
  end
end
