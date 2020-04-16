class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :created_at, :rating
  belongs_to :category
  belongs_to :user

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end

  def rating
    if object.ratings.size > 0
      (object.ratings.sum(:rating) / object.ratings.size.to_f).ceil
    end
  end
end
