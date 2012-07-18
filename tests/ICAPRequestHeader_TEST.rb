#!/usr/bin/env ruby

require_relative '../ICAPRequestHeader'

rh = ICAPRequestHeader.new

rh.content_addline("asdfg addddggg")
rh.content_addline("Encapsulated: req-hdr=0, res-hdr=200, a=230, null-body=450\r\n")
rh.content_addline("\r\n")

puts rh.encapsulated_entities
puts rh.num_of_entities


