class HTMLSafeString
  @@references = Hash(UInt64, Bool).new(false)

  def self.references
    @@references
  end

  def self.mark_safe(object_id)
    @@references[object_id] = true
  end

  def self.delete(object_id : UInt64) : Bool?
    references.delete(object_id)
  end

  def self.escape(obj)
    if obj.html_safe?
      obj
    else
      escaped = HTML.escape(obj.to_s)
      references[escaped.object_id] = true
      escaped
    end
  end

  def self.safe?(object_id : UInt64) : Bool
    references[object_id]
  end
end
