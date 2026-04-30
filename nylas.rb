# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.5/nylas_3.1.5_darwin_amd64.tar.gz"
      sha256 "7885501fd027e50be0a3ea4d7faf0cda2d073c9541f0f4d933c617ae1a3c32a3"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.5/nylas_3.1.5_darwin_arm64.tar.gz"
      sha256 "2ec06fdcdfc2526167ec493c8a9e00ea0f72e4d96825cfdc8e5f6269bab52ebc"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.5/nylas_3.1.5_linux_amd64.tar.gz"
      sha256 "98baea9cbb606e13b88e76d1447aa5c9a86aa0c620f3fc213fd4089d0ddd4177"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.5/nylas_3.1.5_linux_arm64.tar.gz"
      sha256 "0622b2ef9865634a266adfa85a315eba7ace08626b2a950552109040b6857481"
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
