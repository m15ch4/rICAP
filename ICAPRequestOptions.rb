#!/usr/bin/env ruby

require 'socket'

class ICAPRequestOptions
  def initialize(header)
    @header = header
  end
end