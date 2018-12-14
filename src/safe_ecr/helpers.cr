module SafeECR
  module Helpers
    def h(obj)
      SafeECR.escape(obj)
    end

    def raw(html)
      html.to_s.html_safe
    end
  end

  def self.escape(sb : SafeBuffer)
    HTML.escape(sb.to_s)
  end

  def self.escape(obj)
    if (o = obj)
      HTML.escape(o.to_s)
    end
  end
end
