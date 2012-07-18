#!/usr/bin/env ruby

class ICAPResponseOptions
  def initialize
    @content = []
    @content << "ICAP/1.0 200 OK"
    @content << "Methods: RESPMOD"
    @content << "ISTag: \"1234567890\""
    @content << "Encapsulated: null-opt=0"
    @content << "Allow: 204"
    @content << "Preview: 0"
    @content << "Transfer-Preview: *"
    @content << "\r\n"
  end
  
  def render
    @content.join("\r\n")
  end
end