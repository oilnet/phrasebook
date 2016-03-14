require 'yaml'

module I18nHelper
  PLURALIZATION_KEYS = %w[
    zero
    one
    two
    few
    many
    other
  ]

  def locale_keys
    @locale_keys ||= {}
  end

  def load_locale_keys
    Dir["config/locales/??.yml"].each do |file|
      locale = File.basename(file).split('.').first
      hash = YAML.load_file(file)[locale] || {}
      locale_keys[locale] = get_flat_keys(hash)
    end
  end

  def unique_keys
    locale_keys.values.flatten.uniq.reject {|i| i=='' || i.nil?}.sort
  end

  def get_flat_keys(hash, path = [])
    hash.map do |k, v|
      new_path = path + [k]

      if v.is_a?(Hash) && looks_like_a_plural?(v)
        v = nil
      end

      case v
        when Hash   then get_flat_keys(v, new_path)
        when String then new_path.join('.')
      end
    end.flatten
  end

  def looks_like_a_plural?(hash)
    hash.keys.length > 1 && hash.keys.all? {|k| PLURALIZATION_KEYS.include?(k)}
  end
end
