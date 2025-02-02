require 'chunky_png'

ASCII_CHARS = ['@', '#', '8', '&', 'o', ':', '*', '.', ' '].freeze

def image_to_ascii(image_path, width = 100)
  image = ChunkyPNG::Image.from_file(image_path)

  aspect_ratio = image.height.to_f / image.width
  new_height = (width * aspect_ratio).to_i

  resized = image.resample_nearest_neighbor(width, new_height)

  ascii_art = resized.pixels.each_slice(resized.width).map do |row|
    row.map do |pixel|
      r = ChunkyPNG::Color.r(pixel)
      g = ChunkyPNG::Color.g(pixel)
      b = ChunkyPNG::Color.b(pixel)
      brightness = (r + g + b) / 3
      ASCII_CHARS[(brightness * ASCII_CHARS.size / 256).to_i]
    end.join
  end.join("\n")

  ascii_art
end

puts image_to_ascii('image.png')
