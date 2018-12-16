require "./ecr"
require "./safe_ecr/helpers"
require "./safe_ecr/html_safe_string"

# Inspired by ActiveSupport's output safety features
module SafeECR
  VERSION = "0.2.0"

  def self.escape(obj)
    obj.html_safe? ? obj : HTML.escape(obj.to_s)
  end
end

class String
  def html_safe : SafeECR::HTMLSafeString
    SafeECR::HTMLSafeString.new(self)
  end
end

class Object
  def html_safe?
    false
  end

  def to_html_safe_s
    html_safe? ? to_s : SafeECR.escape(self).to_s
  end

  def to_html_safe_s(io)
    html_safe? ? to_s(io) : SafeECR.escape(self).to_s(io)
  end
end

struct Number
  def html_safe?
    true
  end
end

struct Nil
  def html_safe?
    true
  end
end
