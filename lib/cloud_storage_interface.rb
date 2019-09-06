module CloudStorageInterface; end

Gem.
  find_files("cloud_storage_interface/**/*.rb").
  sort_by { |path| path.count("/") }.
  each &method(:require)
