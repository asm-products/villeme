# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require_relative '../app/domain/schedules/clean_cache_fragments_daily'

every 1.days, at: '0:01 am' do
  runner Schedule::CleanCacheFragmentDaily.initialize, environment: 'production'
end

every 3.days, at: '5:00 am' do
  runner Schedule::CleanGuestUsers.initialize, environment: 'production'
end