class ResourceFactory
  def self.create(type, attributes)
    case type.downcase
    when 'book'
      Book.new(attributes)
    when 'journal'
      Journal.new(attributes)
    else
      raise ArgumentError, "Unknown resource type: #{type}"
    end
  end
  
  def self.search(type, query)
    case type.downcase
    when 'book'
      Book.search(query)
    when 'journal'
      Journal.search(query)
    when 'all'
      {
        books: Book.search(query),
        journals: Journal.search(query)
      }
    else
      raise ArgumentError, "Unknown resource type: #{type}"
    end
  end
end