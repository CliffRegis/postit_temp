class CreateCatgories < ActiveRecord::Migration
  def change
    create_table :catgories do |t|
      t.string :name
    end
  end
end
