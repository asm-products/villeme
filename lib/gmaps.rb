module Gmaps


  private

  def get_event_objects_for_map
    letter = ('A'..'Z').to_a
    i = 0
    @array_of_events = Array.new

    get_events_in_a_hash.each do |index, value|
      @array_of_events << {latLng: [value[:latitude].to_s, value[:longitude].to_s], id: letter[i].to_s, data: {link: value[:url].to_s, name: index.to_s, address: value[:address]}, options: {icon: "/images/marker-default-" + value[:strong_category].to_s.parameterize + ".png"}}
      i += 1
    end

    @array_of_events << {latLng: [current_user.latitude, current_user.longitude], data: current_user.name.to_s, options: {icon: "/images/marker-default-home.png"}}

    @array_of_events
  end



  def get_events_in_a_hash
    @hash_of_events = Hash.new
    @hash_of_events[@event.name] = {
        latitude: @event.get_latitude,
        longitude: get_event_longitude,
        address: @event.address,
        url: event_url(@event),
        strong_category: strong_category(@event, 'slug')
    }
    @hash_of_events
  end


  def set_user_local
    @array_of_events << {latLng:[current_user.latitude, current_user.longitude], data: current_user.name.to_s, options: {icon: "/images/marker-default-home.png"}}
  end



end
