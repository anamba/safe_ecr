require "./ecr"
require "./safe_ecr/safe_buffer"
require "./safe_ecr/helpers"

# Inspired by ActiveSupport's output safety features
module SafeECR
  VERSION = "0.1.0"
end

class String
  def html_safe
    SafeECR::SafeBuffer.new(self)
  end
end

class Object
  def html_safe?
    false
  end

  def to_html_safe_s(io)
    html_safe? ? to_s(io) : SafeECR.escape(self).to_s(io)
  end
end

class Numeric
  def html_safe?
    true
  end
end
