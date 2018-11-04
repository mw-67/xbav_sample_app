module Concerns
  # logic to declare attributes being identifiers
  # usage: `identifier <attribute_name>, <identifier pattern>`
  # on creation the attribute is filled with a random token,
  # on update the attribute must not be changed.
  module Identifier
    extend ActiveSupport::Concern

    included do
      cattr_accessor :identifiers
      before_create :ensure_identifier
      before_update :protect_identifier
    end

    class_methods do
      def identifier(name, pattern)
        self.identifiers ||= []
        self.identifiers << { name: name, generator: TokenGenerator.new(pattern) }
      end
    end

    def ensure_identifier
      (self.class.identifiers || []).each do |config|
        loop do
          token = config[:generator].token
          next if self.class.where(config[:name] => token).exists?
          self.send("#{config[:name]}=", token)
          break
        end
      end
    end

    def protect_identifier
      (self.class.identifiers || []).each do |config|
        raise "attempt to modify identifier \"#{config[:name]}\" in #{self.class.name}:#{self.id}" if changes[config[:name]]
      end
    end
  end
end
