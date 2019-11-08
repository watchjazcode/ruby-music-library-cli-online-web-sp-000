module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect{|a| a.name == name}
    end
    
    def find_or_create_by_name(name)
      instance = find_by_name(name)
      if instance == nil
        create(name)
      else
        return instance
      end 
    end  
  end
end