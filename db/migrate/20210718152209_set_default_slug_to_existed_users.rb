class SetDefaultSlugToExistedUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :slug, 'asd'
  end
end
