require "./ecr"
require "./html_safe_string"
require "./safe_ecr/helpers"

# Inspired by ActiveSupport's output safety features
module SafeECR
  VERSION = "0.2.0"

  alias HTMLSafeString = ::HTMLSafeString
end

class String
  def html_safe : String
    HTMLSafeString.mark_safe(object_id)
    self
  end

  def +(other : self)
    if !self.html_safe? && !other.html_safe
      previous_def(other)
    elsif self.html_safe?
      previous_def(other.to_html_safe_s).html_safe
    else
      to_html_safe_s + other
    end
  end

  #
  # what about String.build?
  #

  def finalize
    HTMLSafeString.delete(object_id)
    previous_def
  end
end

struct Value
  def html_safe?
    false
  end
end

class Reference
  def html_safe?
    HTMLSafeString.safe?(self.object_id)
  end
end

class Object
  def to_html_safe_s
    (html_safe? ? self : HTMLSafeString.escape(self)).to_s
  end

  def to_html_safe_s(io : IO)
    (html_safe? ? self : HTMLSafeString.escape(self)).to_s(io)
  end
end

struct Nil
  def html_safe?
    true
  end
end

struct Bool
  def html_safe?
    true
  end
end

struct Number
  def html_safe?
    true
  end
end


module Enumerable
  def safe_join(separator = "") : String
    String.build { |io|
      each_with_index do |elem, i|
        io << separator.to_html_safe_s if i > 0 && separator.size > 0
        io << elem.to_html_safe_s
      end
    }.html_safe
  end
end
