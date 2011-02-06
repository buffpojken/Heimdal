class Prowl < Heimdal::Plugin
  
  def self.ping(ident, data)
    
  end
  
end

Heimdal.register_plugin(:prowl, Prowl)