require "./spec_helper"

describe SafeECR do
  it "escapes HTML in unsafe strings and leaves safe strings untouched" do
    "asdf".html_safe?.should be_false
    1.html_safe?.should be_true
    "asdf".html_safe.html_safe?.should be_true

    io = IO::Memory.new
    ECR.embed __DIR__ + "/example.ecr", io
    io.to_s.strip.should eq "&lt;strong&gt;Dangerous HTML!&lt;/strong&gt;\n<em>Safe HTML!</em>\n123"
  end
end
