# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.5/nylas_3.0.5_darwin_amd64.tar.gz"
      sha256 "e221e3e5601c8b1cdacdbde771243fc26c2dd6efff2ce4ab35bc35095a746ca1"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.5/nylas_3.0.5_darwin_arm64.tar.gz"
      sha256 "9f6c5440fa845e9ffc79797ccd4bf87d7198f5057eecbffab6a4944945471844"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.5/nylas_3.0.5_linux_amd64.tar.gz"
      sha256 "2f2703276dc3cd573faad819cf8fe172e1941ba9eb6b7d334134856f10f8e770"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.5/nylas_3.0.5_linux_arm64.tar.gz"
      sha256 "2d6c63f5238eddf935e51aadac15ba5a9bf3ddda0c1feb2719e9956590517f4f"
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
