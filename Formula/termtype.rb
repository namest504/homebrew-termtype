# typed: false
# frozen_string_literal: true

class Termtype < Formula
  desc "A simple typing practice application for your terminal."
  homepage "https://github.com/namest504/termtype"
  url "https://github.com/namest504/termtype/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "84cb8e9d6b24ab227c422c199696204a48c3a2499671a5dd6ba69cb98a50e8d0"

  license "MIT"

  on_macos do
    on_arm do # Apple Silicon
      url "https://github.com/namest504/termtype/releases/download/v0.2.3/termtype_darwin_arm64.tar.gz"
      sha256 "ee76639c7dc202f6116e45650c0db52991f88f91d23bee90b8994b3ae9323f36"
    end
    on_intel do # Intel Mac
      url "https://github.com/namest504/termtype/releases/download/v0.2.3/termtype_darwin_amd64.tar.gz"
      sha256 "26ddd4165bf1db9cc503df8d36f269138178f65a4c449d808d4e0377940197f5"
    end
  end

  on_linux do
    on_arm do # Linux ARM
      url "https://github.com/namest504/termtype/releases/download/v0.2.3/termtype_linux_arm64.tar.gz"
      sha256 "124c21046db4d2f16bc7af16220b52eb3599a197f5258ba3386cdddebbbc3501"
    end
    on_intel do # Linux Intel/AMD
      url "https://github.com/namest504/termtype/releases/download/v0.2.3/termtype_linux_amd64.tar.gz"
      sha256 "b8d000f58912c12eff99af1329693527eaf03ceae19bb441213b5cc348597788"
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