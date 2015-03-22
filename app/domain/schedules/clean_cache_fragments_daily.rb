module Schedule
  class CleanCacheFragmentDaily

    def self.initialize
      Rails.cache.clear
    end

  end
end