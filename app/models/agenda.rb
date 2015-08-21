class Agenda < ActiveRecord::Base
	belongs_to :user
	belongs_to :item, counter_cache: true
end
