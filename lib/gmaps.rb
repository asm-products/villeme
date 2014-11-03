module Gmaps


  private
  def get_event_objects_for_map
    letter = ('A'..'Z').to_a
    i = 0
    @events_local_array = Array.new

    set_events_local.each do |index, value|
      @events_local_array << {latLng: [value[:latitude].to_s, value[:longitude].to_s], id: letter[i].to_s, data: {link: value[:url].to_s, name: index.to_s, address: value[:address]}, options: {icon: "/images/marker-default-" + value[:strong_category].to_s.parameterize + ".png"}}
      i += 1
    end

    @events_local_array << {latLng: [current_user.latitude, current_user.longitude], data: current_user.name.to_s, options: {icon: "/images/marker-default-home.png"}}

    @events_local_array
  end



  def set_events_local
    @events_local = Hash.new
    @events_local[@event.name] = {
        latitude: @event.get_latitude,
        longitude: get_event_longitude,
        address: @event.address,
        url: event_url(@event),
        strong_category: strong_category(@event, 'slug')
    }
    @events_local
  end


  def set_user_local
    @events_local_array << {latLng:[current_user.latitude, current_user.longitude], data: current_user.name.to_s, options: {icon: "/images/marker-default-home.png"}}
  end



end
