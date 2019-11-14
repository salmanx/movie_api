class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :created_at, :owner
  belongs_to :category
  belongs_to :user

  def created_at
  	object.created_at.strftime('%F')  	
  end

  def owner
  	(object.user.first_name.to_s.first.upcase || '') + (object.user.last_name.to_s.first.upcase || '')
  end
end
