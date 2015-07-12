module Schedule
  class CleanGuestUsers

    def self.initialize
      User.destroy_all(guest: true)
    end

  end
end