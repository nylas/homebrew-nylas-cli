# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.1/nylas_3.0.1_darwin_amd64.tar.gz"
      sha256 "bcde4e0db2525b543ff6729083c923a254922d7991498d53cff61999dcf0d27d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.1/nylas_3.0.1_darwin_arm64.tar.gz"
      sha256 "a869985bdeb5c46e6f1a194f91aa0d88df3252ee49d73e6c4c0fd11e2b9bbe60"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.1/nylas_3.0.1_linux_amd64.tar.gz"
      sha256 "03b166fcc484f0242c3d6c71d5df043d66833b974ae55b798c3a7426f4ab194d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.1/nylas_3.0.1_linux_arm64.tar.gz"
      sha256 "7a39550a4704c39a56199e61c56c7db77232bb8230f19f258bcde61c2c3f7333"
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
