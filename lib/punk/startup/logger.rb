# frozen_string_literal: true

SemanticLogger.close
SemanticLogger.default_level = PUNK.get.log.level
if PUNK.get.log.enabled?
  case PUNK.get.log.type
  when :stderr
    SemanticLogger.add_appender(io: $stderr)
  when :stdout
    $stdout.sync = true
    SemanticLogger.add_appender(io: $stdout, formatter: :color)
  when :file
    subdir = PUNK.task.server? ? "." : PUNK.task
    path = PUNK.get.log.path || File.join(PUNK.get.app.path, "..", "log", subdir, "#{PUNK.env}.log")
    FileUtils.mkdir_p(File.dirname(path))
    SemanticLogger.add_appender(file_name: path, formatter: :color)
  else
    raise InternalServerError, "Unknown log type :#{PUNK.get.log.type}!"
  end
end
