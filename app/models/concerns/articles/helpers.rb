module Articles
  module Helpers extend ActiveSupport::Concern
    included do
      before_validation :create_slug
    end

    def create_slug
      self.slug = self.title.parameterize
    end
  end
end