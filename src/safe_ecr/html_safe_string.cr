module SafeECR
  class HTMLSafeString
    @string : String

    def initialize(@string)
    end

    def_equals(@string)

    def html_safe?
      true
    end

    def to_s
      @string
    end

    def to_s(io)
      @string.to_s(io)
    end

    def ==(other : String)
      @string == other
    end

    def +(other : String)
      HTMLSafeString.new(@string + SafeECR.escape(other))
    end

    def +(other : HTMLSafeString)
      HTMLSafeString.new(@string + other.to_s)
    end

    forward_missing_to @string
  end
end

class String
  def +(other : SafeECR::HTMLSafeString)
    SafeECR::HTMLSafeString.new(SafeECR.escape(self) + other.to_s)
  end
end
