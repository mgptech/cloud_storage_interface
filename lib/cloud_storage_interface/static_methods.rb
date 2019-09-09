# frozen_string_literal: true

require 'tempfile'

module CloudStorageInterface::StaticMethods

  # Static helper method
  # Can be used to generate a tempfile given some text
  # This tempfile can then be passed to #upload_file
  def with_tempfile(text, &blk)
    t = Tempfile.new
    t.write text
    t.close
    blk_result = blk.call(t)
    t.close
    t.delete
    return blk_result
  end

  CloudStorageInterface.extend self
end