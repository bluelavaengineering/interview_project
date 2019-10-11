module Common
  module Service
    def self.included(base)
      base.extend(ClassMethods)

      def call
        raise NotImplementedError
      end
    end

    module ClassMethods
      def call(*args, &block)
        new(*args).call(&block)
      end
    end
  end
end
