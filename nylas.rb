# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.14/nylas_3.1.14_darwin_amd64.tar.gz"
      sha256 "4259eaa5b67e94ce8f5d91ded2ad968730118ebd569e7170cc77207924cf6e26"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.14/nylas_3.1.14_darwin_arm64.tar.gz"
      sha256 "40428d254fc26fb184e59241c2fcea5834d4b02aa9d1dfde9be14b13c15f5daa"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.14/nylas_3.1.14_linux_amd64.tar.gz"
      sha256 "246b58c570f79d05cefdeb44210e6b3770a2c329a3e6d8a8c09f571d939d5dc0"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.14/nylas_3.1.14_linux_arm64.tar.gz"
      sha256 "47670b6ca2106b612c1188175cf9f176a4c7c088cb780d2d42c6e4b32d5300f0"
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
