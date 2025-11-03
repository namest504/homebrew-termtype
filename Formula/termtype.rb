# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.1.3-test.tar.gz"
  sha256 "19301f047efcf6e3a2e16ff9e85c0505ef051c9156c3e4334d8eb17471f7200c"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", "termtype", "./cmd/termtype"
    bin.install "termtype"
  end

  def caveats
    <<~EOS
      To use termtype, run:
        termtype
    EOS
  end

  test do
    system "#{bin}/termtype", "--help"
  end
end