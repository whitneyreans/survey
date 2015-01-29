class CreateQuestion < ActiveRecord::Migration
  def change
    create_table(:questions) do |t|
    t.column(:text, :string)
    t.column(:survey_id, :integer)

    t.timestamps
    end
  end
end
