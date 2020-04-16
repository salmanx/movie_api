class Category < ApplicationRecord
  before_save :create_slug
  has_many :movies

  private

  def create_slug
    self.slug = self.name.parameterize
  end
end
