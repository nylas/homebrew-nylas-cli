# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.22"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.22/nylas_3.1.22_darwin_amd64.tar.gz"
      sha256 "e386cba949bd7c43a35025140142bbbbaec5761cd9d45b68b91682ca0a0c5c1a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.22/nylas_3.1.22_darwin_arm64.tar.gz"
      sha256 "67718b0662ee8f6f70af6e0b67f4275b18fb28c9e0663f938cd443dd25985b73"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.22/nylas_3.1.22_linux_amd64.tar.gz"
      sha256 "412c4741ac1c704c693308e05f4b3a2383b2228f783b195955df2d27c74666db"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.22/nylas_3.1.22_linux_arm64.tar.gz"
      sha256 "08896a365ebc291c0da40cd3d8eea925484e432782dfa62ebc4ab992601afd55"
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
