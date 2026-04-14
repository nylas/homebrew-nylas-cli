# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.2/nylas_3.1.2_darwin_amd64.tar.gz"
      sha256 "044e0f95113b7ac52b9291fd43bc9988e2f53f00c460e2881e2ce4c205edbd69"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.2/nylas_3.1.2_darwin_arm64.tar.gz"
      sha256 "ebd7c7e26aa37c590c65f5d1234997be3fed2dcf3ce578b9e1ab42bf068e5117"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.2/nylas_3.1.2_linux_amd64.tar.gz"
      sha256 "f14fd1f1b6be795be3083cc8d17ecbe1d1b6eb5b546a6a293c0bdae331c87aa7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.2/nylas_3.1.2_linux_arm64.tar.gz"
      sha256 "6a85ed2ef8353c2d1034783d61dd4c5d778f7e6608da042ebd741879bd44f429"
    end
  end

  def install
    bin.install "nylas"

    # Install shell completions
    # Disable keyring during completion generation to avoid macOS Keychain prompts
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    generate_completions_from_executable(bin/"nylas", "completion")
  end

  test do
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    system "#{bin}/nylas", "--version"
  end
end
