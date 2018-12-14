require "./spec_helper"

describe SafeECR do
  it "escapes HTML in unsafe strings and leaves safe strings untouched" do
    io = IO::Memory.new
    ECR.embed __DIR__ + "/example.ecr", io
    io.to_s.strip.should eq "&lt;strong&gt;Dangerous HTML!&lt;/strong&gt;\n<em>Safe HTML!</em>\n123"
  end
end
