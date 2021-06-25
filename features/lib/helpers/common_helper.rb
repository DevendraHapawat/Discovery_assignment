# This class is used to keep common functions.
class CommonHelper
    @short_wait = 10
 	@long_wait = 30
    @timeout_wait = 60

  class << self
    attr_accessor :short_wait, :long_wait, :timeout_wait

  def create_report_directories
      dire_names = ['./reports', './results', './screenshots']
      (0...dire_names.size).each do |index|
        dirname = File.dirname(dire_names[index])
        FileUtils.mkdir_p(dire_names[index]) unless File.directory?(dire_names[index])
      end
    end

    def load_config_file(file_name)
      YAML.load(File.read("./test_data/#{file_name}.yml"))
    end

    def wait_for_element_to_present(locator, locator_type = :css)
      present = false
      count = 0
      until present
        begin
          present = page.find(locator_type, locator).present?
        rescue Exception => e
          present = false
        end
        puts "Waiting for element to present on the page..."
        sleep 1
        count += 1
        raise 'Element is not present on the page.' if count > long_wait
      end
      puts 'sucessfully found element on the page.'
    end
  end
end
