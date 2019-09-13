# frozen_string_literal: true

# =========================================
# This is the 'abstract' interface. It provides a template
# for other classes to follow. It should not be invoked directly.
# =========================================

class CloudStorageInterface::AbstractInterface

  # REQUIRED TO OVERRIDE
  # =====================
  def initialize(**opts)
    raise(
      "Do not use this class directly. " +
      "Use CLOUD_STORAGE_ADAPTER instead, which is a singleton instance " +
      "configured to use a particular cloud storage provider."
    )
  end

  # REQUIRED TO OVERRIDE
  # =====================
  # PARAMS:
  #   opts can contain:
  #     - multipart_threshold  
  # RETURNS:
  #   { checksum: <string> }
  def upload_file(bucket_name:, key:, file:, **opts); end

  # REQUIRED TO OVERRIDE
  # =====================
  # PARAMS
  #   expires_in is given in seconds and cannot be more than 1 week
  #   (due to S3 limitations)
  # RETURNS <string>
  def presigned_url(bucket_name:, key:, expires_in:); end

  # REQUIRED TO OVERRIDE
  # =====================
  # RETURNS nil
  def delete_file!(bucket_name:, key:); end

  # REQUIRED TO OVERRIDE
  # =====================
  # RETURNS <bool>
  def file_exists?(bucket_name:, key:); end

  # REQUIRED TO OVERRIDE
  # =====================
  # PARAMS
  #   opts can contain
  #     - prefix
  # RETURNS:
  #   List of <object>s
  #   where <object> = { key: <string> }
  def list_objects(bucket_name:, **opts); end

  # REQUIRED TO OVERRIDE
  # =====================
  # RETURNS <string>
  # NOTE this is an unsigned static URL, and will only work if the bucket/obj is public
  def public_url(bucket_name:, key:); end

  # REQUIRED TO OVERRIDE
  # =====================
  # PARAMS
  #   opts can contain
  #     - success_action_status
  #     - acl
  # RETURNS:
  #   { fields: <object>, url: <string> }
  def presigned_post(bucket_name:, key:, **opts); end

end