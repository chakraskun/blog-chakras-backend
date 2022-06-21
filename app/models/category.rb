class Category < ApplicationRecord
  has_many :articles
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # before_save :assign_url_param

  # def assign_url_param
  #   self.url_param = self.name.parameterize
  # end
end
