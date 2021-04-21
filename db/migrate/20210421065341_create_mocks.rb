class CreateMocks < ActiveRecord::Migration[6.1]
  def change
    create_table :mocks do |t|
      t.string :request
      t.string :response

      t.timestamps
    end
  end
end
