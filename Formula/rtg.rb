class Rtg < Formula
  desc "A terminal-first Telegram client written in Rust."
  homepage "https://github.com/bercly0b/rtg"
  version "0.1.18"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.18/rtg-tui-aarch64-apple-darwin.tar.xz"
      sha256 "ea389f4cc07bc9fa161e2f9677f1a31affb3a64deb7fcfcbf30c9ab90c2713bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.18/rtg-tui-x86_64-apple-darwin.tar.xz"
      sha256 "0a5ce3c799316dd9697da8df845cdf38512ebacd02adf1537bdc03b3415ad2cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.18/rtg-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f19d656ccc81dcacc1f5104afe25958c89b793bc2aad2152c69ae7df65fc1094"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.18/rtg-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "354fb82b577d90b06aa581637d9153e0e4778adab26112ff39a5968cfac045bd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rtg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rtg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rtg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rtg"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
