class Search
  attr_accessor :key, :type

  def initialize
  end

  def search key = nil, type = []
    @results =  []
    type.each do |t|
      @results << Object.const_get(t).name_like(key)
    end
    @results
  end
end
