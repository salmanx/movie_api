class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :created_at, :owner, :rating
  belongs_to :category
  belongs_to :user

  def created_at
  	object.created_at.strftime("%B %d, %Y")  	
  end

  def owner
  	(object.user.first_name.capitalize || '') +  ' ' + (object.user.last_name.capitalize || '')
  end

  def rating
	(object.ratings.sum(:rating) / object.ratings.size.to_f).ceil if object.ratings.size > 0 
  end
end
