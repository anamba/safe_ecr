require "./spec_helper"

describe HTMLSafeString do
  it "wraps a string that is safe to output directly, and can be compared" do
    obj = "asdf".html_safe
    obj.should be_a String
    obj.to_s.should eq "asdf"
    obj.should eq "asdf"
    # obj.should eq String.new("asdf")
  end

  it "can be combined with other safe strings" do
    ("asdf".html_safe + "fdsa".html_safe).to_html_safe_s.should eq "asdffdsa"
    ("asdf".html_safe + "fd<br>sa1".html_safe).to_html_safe_s.should eq "asdffd<br>sa1"
  end

  it "can be combined with non-safe strings after escaping" do
    # don't forget, crystal reuses literal strings if contents are identical
    ("asdf".html_safe + "fdsa").to_html_safe_s.should eq "asdffdsa"
    ("fdsa" + "asdf".html_safe).to_html_safe_s.should eq "fdsaasdf"
    ("asdf".html_safe + "fd<br>sa2").to_html_safe_s.should eq "asdffd&lt;br&gt;sa2"
    ("fd<br>sa3" + "asdf".html_safe).to_html_safe_s.should eq "fd&lt;br&gt;sa3asdf"
  end

  it "adds #safe_join to Enumerable" do
    ["fd<br>sa".html_safe, "asdf"].join(" ").to_html_safe_s.should eq "fd&lt;br&gt;sa asdf"
    ["fd<br>sa".html_safe, "asdf"].safe_join(" ").to_html_safe_s.should eq "fd<br>sa asdf"
    ["fd<br>sa".html_safe, "asdf"].safe_join("<br>").to_html_safe_s.should eq "fd<br>sa&lt;br&gt;asdf"
    ["fd<br>sa".html_safe, "asdf"].safe_join("<br>".html_safe).to_html_safe_s.should eq "fd<br>sa<br>asdf"
  end
end
