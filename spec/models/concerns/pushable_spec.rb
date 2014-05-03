require 'spec_helper'

class DummyModel < ActiveRecord::Base
  include Pushable

  def to_json
    '{}'
  end
end

describe Pushable do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    migration = ActiveRecord::Migration.new
    migration.verbose = false
    migration.create_table :dummy_models
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
    migration = ActiveRecord::Migration.new
    migration.verbose = false
    migration.drop_table :dummy_models
  end

  describe 'after commit on create' do
    it 'triggers the corresponding Pusher notification' do
      dummy_model = DummyModel.new
      Pusher.should_receive(:trigger).with('lion', 'dummy_model.create', '{}')
      dummy_model.save
    end
  end

  describe 'after commit on update' do
    it 'triggers the corresponding Pusher notification' do
      dummy_model = DummyModel.new
      dummy_model.save
      Pusher.should_receive(:trigger).with('lion', 'dummy_model.update', '{}')
      dummy_model.update({})
    end
  end

  describe 'after commit on destroy' do
    it 'triggers the corresponding Pusher notification' do
      dummy_model = DummyModel.new
      dummy_model.save
      Pusher.should_receive(:trigger).with('lion', 'dummy_model.destroy', '{}')
      dummy_model.destroy
    end
  end
end
