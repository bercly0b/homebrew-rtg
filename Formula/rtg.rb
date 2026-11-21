class Rtg < Formula
  desc "RTG — a fast Telegram TUI client for the terminal, written in Rust"
  homepage "https://github.com/bercly0b/rtg"
  version "0.1.19"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.19/rtg-tui-aarch64-apple-darwin.tar.xz"
      sha256 "a5eddb59b805e135e4831757e4176676193ddc1a7782c346e085330069e3d75f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.19/rtg-tui-x86_64-apple-darwin.tar.xz"
      sha256 "6fd2e2e83060849cb95465d723730abf5b13d7749ff8c3535f362b70f2e15376"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.19/rtg-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "532e64c814e18ad8f63429dc69960ef9d5fa44c4639897f9372ce8a964bf813e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.19/rtg-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "49e360be2bde004ba7047e98a5284e3bdb5dabee30693fd869376ea1f4951217"
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
