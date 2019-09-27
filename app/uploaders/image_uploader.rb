class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [400, 300]

end




Access Key ID:
AKIAJ3RZHLFVO6RSP5CQ
Secret Access Key:
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

