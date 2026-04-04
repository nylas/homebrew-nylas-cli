# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.1/nylas_3.1.1_darwin_amd64.tar.gz"
      sha256 "611a69b1d9d33ebbf24bf9355aa438e0cb90d0d4cb661a3b30e68d9482d0a4d8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.1/nylas_3.1.1_darwin_arm64.tar.gz"
      sha256 "6c3ef925db87c9fd5816736ebb747de432769e4e4e8d311f12fe13e77d973863"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.1/nylas_3.1.1_linux_amd64.tar.gz"
      sha256 "d539ebb649a3a0cf927b793b75da2bdde1990a8817fd53fc44683c7d12d38974"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.1/nylas_3.1.1_linux_arm64.tar.gz"
      sha256 "eddd1cdd37cfa0c1f7958dcfbb471c9055755e90cda1425c9ed51c9d5918f576"
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
