class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :created_at, :owner
  belongs_to :category
  belongs_to :user

  def created_at
  	object.created_at.strftime('%F')  	
  end

  def owner
  	(object.user.first_name.capitalize || '') +  ' ' + (object.user.last_name.capitalize || '')
  end
end
