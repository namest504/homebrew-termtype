# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "709569e883ab20022dd3663df9a95d05872be5c31854d892f2e40ed694767a0d"

  license "MIT"

  on_macos do
    on_arm do # Apple Silicon
      url "https://github.com/namest504/termtype/releases/download/v0.2.4/termtype_darwin_arm64.tar.gz"
      sha256 "842c0e94e3b1d5a9199911cb0e5b71c20bea890731b128ea4a457e1fbb7d10f4"
    end
    on_intel do # Intel Mac
      url "https://github.com/namest504/termtype/releases/download/v0.2.4/termtype_darwin_amd64.tar.gz"
      sha256 "9dcaedb0f49b99efc9f696022b90b74d4ea7a7f002d210a49beb0603216baf9c"
    end
  end

  on_linux do
    on_arm do # Linux ARM
      url "https://github.com/namest504/termtype/releases/download/v0.2.4/termtype_linux_arm64.tar.gz"
      sha256 "787905155645d2977659f015e581b1a4ab7e423718ee7912baa56d00614600d5"
    end
    on_intel do # Linux Intel/AMD
      url "https://github.com/namest504/termtype/releases/download/v0.2.4/termtype_linux_amd64.tar.gz"
      sha256 "a65dbf266485beb3f95542df28198e9da02cd051a861728ec837294a893a00ac"
    end
  end

  depends_on "go" => :build

  def install
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