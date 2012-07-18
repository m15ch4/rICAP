#!/usr/bin/env ruby

require 'socket'
require_relative 'messages/ICAPRequestHeader'
require_relative 'messages/ICAPRequestRESPMOD'
require_relative 'messages/ICAPResponseOptions'
require_relative 'messages/ICAPResponseContinue'



class ICAPServer

  def initialize
    @serverSocket = TCPServer.new 1344
  end
  
  def get_entity(clientSocket, entity_name, requestRESPMOD)
    entity_content = []
    loop do
      rcvline = clientSocket.gets
      entity_content << rcvline
      break if rcvline =~ /^\r\n$/ #poprawic
    end
    requestRESPMOD.add_entity(entity_name, entity_content)  
  end
  
  def start
    puts "Starting..."
    loop do
      Thread.start(@serverSocket.accept) do |clientSocket|
	loop do
	  requestHeader = ICAPRequestHeader.new

	  loop do
	    rcvline = clientSocket.gets
	    requestHeader.content_addline(rcvline)
	    break if rcvline =~ /^\r\n$/    #poprawic
	  end
	
	  if requestHeader.type == :OPTIONS
	    responseOptions = ICAPResponseOptions.new
	    clientSocket.puts responseOptions.render
	
	  elsif requestHeader.type == :RESPMOD
	    requestRESPMOD = ICAPRequestRESPMOD.new (requestHeader)
	    requestRESPMOD.entities_to_get.each do |entity_name|
	      get_entity(clientSocket, entity_name, requestRESPMOD)
	    end
	    if requestRESPMOD.need100continue?
	      clientSocket.puts ICAPResponseContinue.new.render
	      get_entity(clientSocket, "res-body", requestRESPMOD)
	    end
	    
	    requestRESPMOD.print_entities
	    
	  elsif requestHeader.type == :REQMOD
	    puts :REQMOD
	  
	  else
	    puts :UNKNOWN
	  end
	end #Thread in loop
      end #Thread
    end #main loop
  end # def start

=begin
	      puts "\r\nTHIS IS RESPONSE"
	      response_header = []
	      response_header << "ICAP/1.0 200 OK"
	      response_header << "Date: Mon, 10 Jan 2000  09:55:21 GMT"
	      response_header << "Server: rICAP/1.0"
	      response_header << "Connection: close"
	      response_header << "ISTag: \"1234567890\""
	      puts "TO JEST MMMMMMMMMMMM"
	      puts @m
	      response_header << "Encapsulated: #{@m.join(", ")}"
	      response = []
	      response << response_header.join("\r\n")
	      msg2.each do |response_part|
		response << response_part
		puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		puts response_part
		puts response_part.size+2
	      end
	      puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		
	      response.delete_at(1)
	      response[-1] = content.join
	      
	      r = response.join("\r\n\r\n")
	      puts r
	      clientSocket.puts r
	      
	    elsif msg[0] =~ /^REQMOD /
	      puts "PARSING REQMOD"
	    else
	      puts "BAD REQUEST"
	    end
	  end
	end #loop
      end #Thread.start
    end #loop
  end #start
=end
	
end #ICAPServer  

s = ICAPServer.new
s.start

