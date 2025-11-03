# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.1.0-test.tar.gz"
  sha256 "297fecaeae584379c468a057688bcacd2738ca7144dbe210efdd66b79a487b02"
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