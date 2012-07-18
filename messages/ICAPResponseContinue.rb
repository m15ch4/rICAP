#!/usr/bin/env ruby

class ICAPResponseContinue
  def initialize
    @content = []
    @content << "ICAP/1.0 100 CONTINUE"
    @content << "\r\n"
  end
  
  def render
    @content.join("\r\n")
  end
end