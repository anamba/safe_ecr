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
    ("asdf".html_safe + "fdsa".html_safe).to_html_safe_s.should eq "asdffdsa"
    ("asdf".html_safe + "fd<br>sa".html_safe).to_html_safe_s.should eq "asdffd<br>sa"
  end

  it "can be combined with non-safe strings after escaping" do
    ("asdf".html_safe + "fdsa").to_html_safe_s.should eq "asdffdsa"
    ("fdsa" + "asdf".html_safe).to_html_safe_s.should eq "fdsaasdf"
    ("asdf".html_safe + "fd<br>sa").to_html_safe_s.should eq "asdffd&lt;br&gt;sa"
    ("fd<br>sa" + "asdf".html_safe).to_html_safe_s.should eq "fd&lt;br&gt;saasdf"
  end

  it "adds #safe_join to Enumerable" do
    ["fd<br>sa".html_safe, "asdf"].join(" ").to_html_safe_s.should eq "fd&lt;br&gt;sa asdf"
    ["fd<br>sa".html_safe, "asdf"].safe_join(" ").to_html_safe_s.should eq "fd<br>sa asdf"
    ["fd<br>sa".html_safe, "asdf"].safe_join("<br>").to_html_safe_s.should eq "fd<br>sa&lt;br&gt;asdf"
    ["fd<br>sa".html_safe, "asdf"].safe_join("<br>".html_safe).to_html_safe_s.should eq "fd<br>sa<br>asdf"
  end
end
