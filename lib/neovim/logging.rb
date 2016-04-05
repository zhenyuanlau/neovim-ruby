require "logger"
require "stringio"

module Neovim
  # Mixed into classes for unified logging helper methods.
  module Logging
    class << self
      attr_writer :logger
    end

    # Return the value of @logger, or construct it from the environment.
    # $NVIM_RUBY_LOG_FILE specifies a file to log to (default +STDOUT+), while
    # NVIM_RUBY_LOG_LEVEL specifies the level (default +WARN+)
    def self.logger
      return @logger if instance_variable_defined?(:@logger)

      if env_file = ENV["NVIM_RUBY_LOG_FILE"]
        @logger = Logger.new(env_file)
      else
        @logger = Logger.new(STDERR)
      end

      if env_level = ENV["NVIM_RUBY_LOG_LEVEL"]
        if Logger.const_defined?(env_level.upcase)
          @logger.level = Logger.const_get(env_level.upcase)
        else
          @logger.level = Integer(env_level)
        end
      else
        @logger.level = Logger::WARN
      end

      @logger
    end

    def self.included(base)
      base.send(:include, Helpers)
    end

    module Helpers
      private

      def fatal(msg)
        logger.fatal(self.class) { msg }
      end

      def warn(msg)
        logger.warn(self.class) { msg }
      end

      def info(msg)
        logger.info(self.class) { msg }
      end

      def debug(msg)
        logger.debug(self.class) { msg }
      end

      def logger
        Logging.logger
      end
    end
  end
end
