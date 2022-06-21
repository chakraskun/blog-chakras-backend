class Article < ApplicationRecord
  include Articles::Helpers
  include PgSearch::Model

  belongs_to :category
  belongs_to :user

  validates :title,
    :outline,
    :content,
    presence: true

  validates :title, uniqueness: { case_sensitive: false }

  pg_search_scope :search,
    against: [:title, :outline]

  scope :regular, -> {
    where(shown: true)
      .where.not(published_at: nil)
      .where('published_at <= ?', DateTime.now)
      .order('published_at DESC')
  }

  scope :for_admin, -> {
    order(updated_at: :desc)
  }

  private

    def published?
      shown && published_date <= DateTime.now
    end
end
