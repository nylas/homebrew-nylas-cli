# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.31"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.31/nylas_3.1.31_darwin_amd64.tar.gz"
      sha256 "a716cfe9efe301e2e139e286742749bbce0bd8619406d0fc7ac462448fdb3512"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.31/nylas_3.1.31_darwin_arm64.tar.gz"
      sha256 "005a702508ba6b6260b2e5033da67d4e47a2ed38b3e4d9c6d07aacb159e0d7b2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.31/nylas_3.1.31_linux_amd64.tar.gz"
      sha256 "aa7d43688704b6e1ba11b7f7946aed65e4295357bd8c0bacecb109d8ddddd241"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.31/nylas_3.1.31_linux_arm64.tar.gz"
      sha256 "acdeb17eef730370f32732f89af605788575e74a1dda425eff8c0068013e3d06"
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
