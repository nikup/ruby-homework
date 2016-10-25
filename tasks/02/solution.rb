class Hash
  def fetch_deep(path)
    prop = path.split('.')
    result = self

    prop.each { |x| result = result[x.to_i] || result[x] || result[x.to_sym] }
    result
  end

  def reshape(shape)
    shape.map do |key, value|
      [key, value.is_a?(String) ? self.fetch_deep(value) : self.reshape(value)]
    end.to_h
  end
end

class Array
  def reshape(shape)
    self.map { |e| e.reshape(shape) }
  end
end