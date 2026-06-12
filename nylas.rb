# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.19"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.19/nylas_3.1.19_darwin_amd64.tar.gz"
      sha256 "a97b53ce124ff7dcb37cf1712d2cd9abea837293b18cc571a5154f3be8847447"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.19/nylas_3.1.19_darwin_arm64.tar.gz"
      sha256 "a6c4d86695f2bee381e69271ae2114404c6496a4527004d8e616bf708767fab3"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.19/nylas_3.1.19_linux_amd64.tar.gz"
      sha256 "ea60612ca5dfe9ed4a0ae08537f90b557b9a71ff1f2b6ca6f720fc74d44b81b7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.19/nylas_3.1.19_linux_arm64.tar.gz"
      sha256 "174726f4a05f4f2dba992cefc3c1ff4c489ebb73cda376bfac042de13bf03938"
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
