require "./spec_helper"

describe SafeECR::HTMLSafeString do
  it "wraps a string that is safe to output directly, and can be compared" do
    obj = "asdf".html_safe
    obj.should be_a SafeECR::HTMLSafeString
    obj.to_s.should eq "asdf"
    obj.should eq "asdf"
    obj.should eq SafeECR::HTMLSafeString.new("asdf")
  end

  it "can be combined with other safe strings" do
    ("asdf".html_safe + "fdsa".html_safe).should eq "asdffdsa".html_safe
    ("asdf".html_safe + "fd<br>sa".html_safe).should eq "asdffd<br>sa".html_safe
  end

  it "can be combined with non-safe strings after escaping" do
    ("asdf".html_safe + "fdsa").should eq "asdffdsa".html_safe
    ("fdsa" + "asdf".html_safe).should eq "fdsaasdf".html_safe
    ("asdf".html_safe + "fd<br>sa").should eq "asdffd&lt;br&gt;sa".html_safe
    ("fd<br>sa" + "asdf".html_safe).should eq "fd&lt;br&gt;saasdf".html_safe
  end
end
