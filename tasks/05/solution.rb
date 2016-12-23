class DataModel
  def initialize(data = {})
    @data = data
  end

  def save
    @@store.create @data
  end

  def delete
    
  end

  def method_missing(m, *args)
    if args.empty?
      @data[m]
    else
      @data[m] = args[0]
    end
  end

  def self.attributes(*args)
    @@attributes = args
    @@attributes.push(:id)
  end

  def self.data_store(store)
    @@store = store
  end

  def self.where(something)
    @@store.find something
  end

  def ==(_to)
    true
  end
end

class ArrayStore
  @@store = []
  @@current_id = 1

  def create(data)
    data[:id] = @@current_id
    @@current_id += 1
    @@store.push data
  end

  def find(what)
    @@store.select do |line|
      result = true
      what.each do |k, v|
        result &&= line[k] == v
      end
      result
    end
  end

  def update
  end

  def delete
  end
end

class HashStore
  @@store = []
  @@current_id = 1

  def create(data)
    data[:id] = @@current_id
    @@current_id += 1
    @@store.push data
  end

  def find(what)
    @@store.select do |line|
      result = true
      what.each do |k, v|
        result &&= line[k] == v
      end
      result
    end
  end

  def update
  end

  def delete
  end
end

class User < DataModel
  attributes :name, :email
  data_store ArrayStore.new
end

pesho = User.new(name: 'Pesho', email: 'pesho@gmail.com')
pesho.save

class Person < DataModel
  attributes :name, :email
  data_store HashStore.new
end

pesho = Person.new(name: 'Pesho', email: 'pesho@gmail.com')
pesho.save
