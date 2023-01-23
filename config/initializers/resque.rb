Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}.resque.log"))
Resque.logger.level = Logger::INFO
