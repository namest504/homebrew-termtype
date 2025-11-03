# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "ec4066350f4a1fa193a30c3d4839a4375c4f60b10cb537e0870d0242247614b5"
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