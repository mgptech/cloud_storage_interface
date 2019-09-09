# frozen_string_literal: true

module CloudStorageInterface; end

# Load all dependencies, in the order of their depth
Gem.
  find_files("cloud_storage_interface/**/*.rb").
  sort_by { |path| path.count("/") }.
  each(&method(:require))