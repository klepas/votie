class CreateConferences < ActiveRecord::Migration
  def self.up
    create_table :conferences do |t|
      t.string :name
      t.string :subdomain

      t.timestamps
    end

    add_column :talks, :conference_id, :integer

    # Create a conference and add existing talks to it
    c = Conference.create!(:name => "BarCamp Canberra 2010", :subdomain => "bcc2010")
    Talk.all.each do |t|
      t.conference = c
      t.save!
    end
  end

  def self.down
    drop_table :conferences
    remove_column :talks, :conference_id
  end
end
