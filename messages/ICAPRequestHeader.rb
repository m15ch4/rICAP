

class ICAPRequestHeader
  
  def initialize
    @content = []
    @encapsulated_entities = {}
  end
  
  def type
    return nil if @content == []
    if @content[0] =~ /^OPTIONS /
      return :OPTIONS
    elsif @content[0] =~ /^RESPMOD /
      return :RESPMOD
    elsif @content[0] =~ /^REQMOD /
      return :REQMOD
    else
      return :UNKNOWN
    end
  end
  
  #returns number of non empty entities (sections to get)
  def num_of_entities
    @encapsulated_entities.size
  end
  
  #returns encapsulated_entities
  def encapsulated_entities
    @encapsulated_entities
  end
  
  def content
    @content
  end
  
  # add line to header and check if it is Encapsulated one
  def content_addline(line)
    @content << line
    return if @encapsulated_entities != {}
    if /^Encapsulated: (?<enc_entity>.+)\r\n/ =~ line
      entities_line = $~[:enc_entity].split(", ")
      entities_line.each do |line|
	kvpairs = line.split("=")
	@encapsulated_entities[kvpairs[0]] = kvpairs[1] if kvpairs[0] !~ /null-body/
      end #entities_line.each
    end #if
  end
  
end
