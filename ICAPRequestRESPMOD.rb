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
  
  def print_entities
    @entities.each_value do |v|
      js = v.join.split("\r\n")
      js.each do |pt|
	puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	puts pt
      end
    end
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
  
end