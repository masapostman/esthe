module CustomerPersonalNameHolder
	extend ActiveSupport::Concern

	HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}]+\z/
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  included do
  	include StringNormalizer

    before_validation do
      self.staff_family_name = normalize_as_name(staff_family_name)
      self.staff_given_name = normalize_as_name(staff_given_name)
      self.staff_family_name_kana = normalize_as_furigana(staff_family_name_kana)
      self.staff_given_name_kana = normalize_as_furigana(staff_given_name_kana)
    end

    validates :staff_family_name, :staff_given_name, presence: true,
      format: { with: HUMAN_NAME_REGEXP, allow_blank: true }

    validates :staff_family_name_kana, :staff_given_name_kana, presence: true,
      format: { with: KATAKANA_REGEXP, allow_blank: true }
  
   end
end