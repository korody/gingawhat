# encoding: utf-8

class ThumbUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    "default/" + [version_name, "logo.jpg"].compact.join('_')
  end

  # Process files as they are uploaded:
  process   :resize_to_fill => [1920, 1080]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  version :thumb do
    process :resize_to_fill => [300, 300]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
