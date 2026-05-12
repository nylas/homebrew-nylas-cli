# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.8/nylas_3.1.8_darwin_amd64.tar.gz"
      sha256 "3319e10c580ec3b883fcd60fe0d6d8d2d05cfbc520cfd7191929a61829428257"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.8/nylas_3.1.8_darwin_arm64.tar.gz"
      sha256 "7d95be59e384f7d8a2c7766a6afea5b5d3db22dbfef9be647cdf0a8d23009722"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.8/nylas_3.1.8_linux_amd64.tar.gz"
      sha256 "48969085e0508d88088967a74f850aa0cba93fc23104649ab91d0a5bfdd8ae39"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.8/nylas_3.1.8_linux_arm64.tar.gz"
      sha256 "14e3676c7ce6ef17f7a42d4a6aa3b020e085383f33cee39a28a082aff809c968"
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
