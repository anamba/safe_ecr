module SafeECR
  class SafeBuffer
    @string : String

    def initialize(@string)
    end

    def html_safe?
      true
    end

    def to_s
      @string
    end

    def to_s(io)
      @string.to_s(io)
    end

    forward_missing_to @string
  end
end
