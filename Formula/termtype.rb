# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.2.2.tar.gz"

  sha256 "eeef957a66e1164bc6641c79ff8ac1826a3e1af9f2feffc6478e970b76e692f9"

  license "MIT"

  
  on_macos do
    on_arm do # Apple Silicon
      url "https://github.com/namest504/termtype/releases/download/v0.2.2/termtype_darwin_arm64.tar.gz"
      sha256 "37052428c9a8550c1b9bc44e33490277ce63373dc75fc65515ba0755d472cc93"
    end
    on_intel do # Intel Mac
      url "https://github.com/namest504/termtype/releases/download/v0.2.2/termtype_darwin_amd64.tar.gz"
      sha256 "6a42cd680b9f9a107da7006f00e56a265e978a27e3a7c3bcd27fbf44268c2266"
    end
  end

  on_linux do
    on_arm do # Linux ARM
      url "https://github.com/namest504/termtype/releases/download/v0.2.2/termtype_linux_arm64.tar.gz"
      sha256 "ae7ab4cbe8ea5e683e045bdbba1137f4357dddbde7bd7f8181b3d1c7ccd55bcb"
    end
    on_intel do # Linux Intel/AMD
      url "https://github.com/namest504/termtype/releases/download/v0.2.2/termtype_linux_amd64.tar.gz"
      sha256 "a2929baf4998f2c9d019d4386c61bd2a634f9cf1dc10ae4881528b375cbe4dca"
    end
  end

  depends_on "go" => :build

  def install
    if build.build_from_source?
      # brew install termtype --build-from-source
      system "go", "build", "-o", "termtype", "./cmd/termtype"
    end
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
