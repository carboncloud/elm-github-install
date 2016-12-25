module ElmInstall
  # This module contains utility functions.
  module Utils
    module_function

    CONVERTERS = {
      /v<(?!=)(.*)/ => '<',
      /(.*)<=v/ => '>=',
      /v<=(.*)/ => '<=',
      /(.*)<v/ => '>'
    }.freeze

    def transform_constraint(constraint)
      constraint.gsub!(/\s/, '')

      CONVERTERS.map do |regexp, prefix|
        match = constraint.match(regexp)
        "#{prefix} #{match[1]}" if match
      end.compact
    end

    # :nocov:
    def log_with_dot(message)
      puts '  ● '.green + message
    end

    def log_with_arrow(message)
      puts "  ▶ #{message}"
    end
    # :nocov:

    def package_version_path(package, version)
      package_name = GitCloneUrl.parse(package).path.sub(/^\//, '')
      [package_name, File.join('elm-stuff', 'packages', package_name, version)]
    end

    def transform_package(key)
      GitCloneUrl.parse(key)
      key
    rescue
      "git@github.com:#{key}"
    end
  end
end
