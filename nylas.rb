# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.17/nylas_3.1.17_darwin_amd64.tar.gz"
      sha256 "c8f2f31658a83a038773384be0e2098aa31cb2927920a9c462bd970451fcf391"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.17/nylas_3.1.17_darwin_arm64.tar.gz"
      sha256 "cf82f8ca3adc61f0fedb4f0bace0a25f4bce190797f1b2b3a2b1f6590ac9721e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.17/nylas_3.1.17_linux_amd64.tar.gz"
      sha256 "52d000321eb16a898fb7f6f6524784b55e954aeae54bf0608fe0d10e7abd0d7d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.17/nylas_3.1.17_linux_arm64.tar.gz"
      sha256 "ceffde764fc00fc7b8e87555554a98411c7c6e02994c8310077c6a3fb5d66874"
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
