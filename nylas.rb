# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.6/nylas_3.1.6_darwin_amd64.tar.gz"
      sha256 "cc5c51d0a7b6848ed6b39b2d043c992cc5f6e10fbfe20f590e0ebb7e0f32a805"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.6/nylas_3.1.6_darwin_arm64.tar.gz"
      sha256 "ae99f8fd15e48c6137b5ee4819cba24f22d74578a5e68a06e1ca6a9eabe2a45d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.6/nylas_3.1.6_linux_amd64.tar.gz"
      sha256 "e8ee99ba77585e7948cfcb58720f08b15dfe46b342937ca6623e56f22242be80"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.6/nylas_3.1.6_linux_arm64.tar.gz"
      sha256 "f3dd9fecd987597c84ce37445ceb5583de4f325b78dac49f920a59d22bbab61c"
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
