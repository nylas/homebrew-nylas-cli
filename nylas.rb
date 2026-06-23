# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.27"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.27/nylas_3.1.27_darwin_amd64.tar.gz"
      sha256 "eb7e39061e4f73b06f27643563307d6e18500338408a3e179574980120e3bd54"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.27/nylas_3.1.27_darwin_arm64.tar.gz"
      sha256 "a6e504ca5e002372740baf085e59cb9c2ffb82b6a3eb03c37e3d5cf1c2f101ce"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.27/nylas_3.1.27_linux_amd64.tar.gz"
      sha256 "74c21a8c74a84b113cc4a07513dc6ecda1fc8657b6b60064ecbe2eed9dee2d6a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.27/nylas_3.1.27_linux_arm64.tar.gz"
      sha256 "9e29536d5ea4f5f52e67d8e16d52e56f5144c1091784a432fbf9f2e304b7a22e"
    end
  end

  def install
    bin.install "nylas"

    # Install shell completions
    # Disable keyring during completion generation to avoid macOS Keychain prompts
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    generate_completions_from_executable(bin/"nylas", "completion")
  end

  def caveats
    <<~EOS
      Get started:
        nylas init

      Install Nylas skills for AI Agents (https://github.com/nylas/skills):
        npx skills add nylas/skills                          # all skills
        npx skills add nylas/skills --skill nylas-api        # individual
        npx skills add nylas/skills --skill nylas-cli

      Documentation: https://cli.nylas.com/
      Issues: https://github.com/nylas/cli/issues
      Changelog: https://github.com/nylas/cli/releases
    EOS
  end

  test do
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    system "#{bin}/nylas", "--version"
  end
end
