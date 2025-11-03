# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.1.1-test.tar.gz"
  sha256 "b2a60e9645cc139f8b8c7f478404bf58327fd47a3737c2146932b27a647c07a7"
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