#!/usr/bin/env ruby

require_relative '../ICAPRequestHeader'
require_relative '../ICAPRequestRESPMOD'


rh = ICAPRequestHeader.new

rh.content_addline("asdfg addddggg")
rh.content_addline("Encapsulated: req-hdr=0, res-hdr=200, null-body=450\r\n")
rh.content_addline("\r\n")

rrespmod = ICAPRequestRESPMOD.new(rh)
                                  
puts rh.encapsulated_entities
puts rh.num_of_entities
puts rrespmod.entities_to_get

