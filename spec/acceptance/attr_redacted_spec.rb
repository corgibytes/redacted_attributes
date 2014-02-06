require 'spec_helper'

db_config_file = File.expand_path('../../config/database.yml', __FILE__)
encryption_config_file = File.expand_path('../../config/symmetric-encryption.yml', __FILE__)

ActiveRecord::Base.configurations = YAML::load(ERB.new(IO.read(db_config_file)).result)
ActiveRecord::Base.establish_connection('test')

ActiveRecord::Schema.define(version: 0) do
  create_table :widgets, force: true do |t|
    t.string :encrypted_name
    t.string :redacted_name
  end
end

class Widget < ActiveRecord::Base
  attr_encrypted :name
  attr_redacted  :name
end

SymmetricEncryption.load!(encryption_config_file, 'test')

# Initialize the database connection
config = YAML.load(ERB.new(File.new(db_config_file).read).result)['test']

Widget.establish_connection(config)

describe 'attr_redacted' do
  it 'sets redacted name on initialization' do
    widget = Widget.new(name: 'Everything')
    expect(widget.redacted_name).to eq('Eve')

    widget.save!

    widget.reload
    expect(widget.redacted_name).to eq('Eve')
  end

  it 'sets redacted name on creation' do
    widget = Widget.create!(name: 'Testing')
    expect(widget.redacted_name).to eq('Tes')

    widget.reload
    expect(widget.redacted_name).to eq('Tes')
  end

  it 'sets redacted name via assignment' do
    widget = Widget.create!

    widget.name = 'Value'
    expect(widget.redacted_name).to eq('Val')

    widget.save!
    expect(widget.redacted_name).to eq('Val')

    widget.reload
    expect(widget.redacted_name).to eq('Val')
  end

  it 'preserves attr_encrypted functionality' do
    widget = Widget.create!(name: 'Anything')
    expect(widget.name).to eq('Anything')
    expect(widget.encrypted_name).to eq(::SymmetricEncryption.encrypt('Anything'))

    widget.reload
    expect(widget.encrypted_name).to eq(::SymmetricEncryption.encrypt('Anything'))
  end
end
