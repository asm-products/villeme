class String
  
  def cut x, y
  	if self.length > y
    	"#{self.slice(x..y)}..."
    else
    	self
    end
  end

end