# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.1.2-test.tar.gz"
  sha256 "eb2f7d728bd1220021dbe17ecea651718f20673f8a4f78a245ac4440edeeb391"
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