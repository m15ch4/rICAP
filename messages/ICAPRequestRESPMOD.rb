#!/usr/bin/env ruby

class ICAPRequestRESPMOD

  def initialize(header)
    @header = header
    @entities = {}
  end
  
  def add_entity(key,value)
    @entities[key] = value
  end
  
  def num_of_entities_to_get
    @header.num_of_entities
  end
  
  def entities_to_get
    @header.encapsulated_entities.keys
  end
  
  def entities
    @entities
  end
  
  def need100continue?
    if @entities.key?("res-body")
      if @entities["res-body"][-2] == "0\r\n"
	return true
      end
    else
      return false
    end
  end

  def remove_resbody_chunk_size
    temp = @entities["res-body"].join.split("\r\n")
    temp2 = []
    temp.each_with_index do |item, i|
      if (i%2) == 1
	temp2 << item
      end
    end
    @entities["res-body"] = temp2.join
  end
  
end