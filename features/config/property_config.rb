# Set the env variable from config file
class PropertConfig
  CONFIG_FILE = 'config_data'
  class << self
    # Reads the config file and set the values in ENV Variables
    def set_env_variables
      read_config_file
      set_variables
    end

    # Read config file.
    def read_config_file
      # @configs = DataHelper.read_config_data(ENV['PROPERTIES'] ||= CONFIG_FILE)
      file_name = ENV['PROPERTIES'] ||= CONFIG_FILE
      @configs = CommonHelper.load_config_file(file_name)
    end

    # Sets ENV variables if not initialize yet
    def set_variables
      ENV['BROWSER_NAME'] ||= @configs[:BROWSER_NAME].downcase
    end
  end
end
