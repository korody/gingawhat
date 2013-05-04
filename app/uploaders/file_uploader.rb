# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    "logo.png"
  end

  # Process files as they are uploaded:
  # process   :resize_to_fill => [1200, 1200]
  process   :resize_to_fill => [1920, 1080]
  
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  version :thumb do
    process :resize_to_fill => [200, 200]
  end

  version :medium do
    process :resize_to_fill => [600, 600]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
