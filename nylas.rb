# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.10/nylas_3.1.10_darwin_amd64.tar.gz"
      sha256 "f365925b5843ed5dae3ecf4c802aaac7a1c65861023f1a69e7c6451adeec8969"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.10/nylas_3.1.10_darwin_arm64.tar.gz"
      sha256 "fe72bee93b147530fc3b8879bdeafbe9083eaaac73e453b443321c0ca24248cd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.10/nylas_3.1.10_linux_amd64.tar.gz"
      sha256 "c30def9dca0d916be63cba7664a9be371214b31a88e4784a20d7a2d97b397ee7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.10/nylas_3.1.10_linux_arm64.tar.gz"
      sha256 "d305a8308c68f637338687a5687dd0ca3b03ca294e9e38981e233eaa93d232de"
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
