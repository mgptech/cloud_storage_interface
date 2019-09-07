# frozen_string_literal: true

require "google/cloud/storage"

class CloudStorageInterface::GcpGcsInterface
    
    PROJECT_ID = ENV.fetch("GCP_PROJECT_ID",'gcp-us-central1-prod')
    
    attr_reader :gcs_client

    def initialize(opts: {})
      @gcs_client = Google::Cloud::Storage.new project: PROJECT_ID
    end

    # NOTE: we don't support upload_opts (multipart_threshold) for GCS.    
    # we also don't return the checksum here.
    def upload_file(bucket_name:, key:, file:, **opts)
      bucket = gcs_client.bucket bucket_name
      bucket.create_file file.path, key
      return {}
    end

    def presigned_url(bucket_name:, key:, expires_in:)
      gcs_client.bucket(bucket_name).file(key).signed_url(expires: expires_in)
    end

    def delete_file!(bucket_name:, key:)
      gcs_client.bucket(bucket_name).file(key).delete
      nil
    end

    def file_exists?(bucket_name:, key:)
      file = gcs_client.bucket(bucket_name).file key
      file&.exists?
    end

    def list_objects(bucket_name:, **opts)
      gcs_client.bucket(bucket_name, **opts).files.map do |file|
        { key: file.name   }
      end
    end

    # this is a static url
    # It will only work for objects that have public read permission
    def build_url(bucket_name:, key:)
      "https://storage.googleapis.com/#{bucket_name}/#{key}"
    end

    # We have no reason to do this right now.
    # If needed in the future, may use this for reference:
    # https://cloud.google.com/storage/docs/xml-api/post-object#usage_and_examples
    def presigned_post(bucket_name:, key:, **opts)
      raise "presigned post unimplemented in #{self.class.name}"
    end

end