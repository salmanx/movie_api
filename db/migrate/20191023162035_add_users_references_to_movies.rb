class AddUsersReferencesToMovies < ActiveRecord::Migration[6.0]
  def change
	  add_reference :movies, :user, index: true
  end
end
