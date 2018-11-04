class BasePresenter
  def self.field(name, opts = {})
    @fields ||= []
    @fields << [name, opts]
  end

  def self.fields
    @fields
  end

  def initialize(instance)
    @instance = instance
  end

  attr_reader :instance
end
