require 'pstore'
class Heimdal
  
  
  def self.add(ident, type, data)
    @@store.transaction do 
      unless @@store[ident]
        @@store[ident] = {}
      end
      @@store[ident][type] = data
    end
  end
  
  def self.list(ident)
    @@store.transaction do 
      @@store[ident].each_pair do |type, data|
        puts "#{type.to_s} has: #{data.inspect}"
      end
    end
  end

  def self.available?(ident, type)
    @@store.transaction do 
      return @@store[ident].key?(type)
    end
  end
  
  def self.register_plugin(type, plugin_class)
    @@plugins[type] = plugin_class
  end
  
  def self.ping(ident, type, msg)
    if @@plugins[type]
      @@plugins[type].ping(ident, msg)
    else
      "puts don't nknow"
    end
  end
  
  @@store     = PStore.new('heimdal.pstore')
  @@plugins   = {}
  
  class Plugin
    def self.ping(ident, msg)
      raise ArgumentError.new("Missing implementation of send for #{self.name}")
    end
  end


end