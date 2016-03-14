require "i18n_helper"

describe "The base i18n files" do
  extend I18nHelper
  load_locale_keys

  locale_keys.each do |locale, keys|
    unique_keys.each do |key|
      it "should translate [#{key}] into [#{locale}]." do
        expect(keys).to include key
      end
    end
  end
end
