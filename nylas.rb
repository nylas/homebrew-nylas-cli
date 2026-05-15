# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.11/nylas_3.1.11_darwin_amd64.tar.gz"
      sha256 "2f26be551453227c777624130ffbd17cc4c33858a23c172ce6fea45c0d7ebc13"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.11/nylas_3.1.11_darwin_arm64.tar.gz"
      sha256 "8fbe6f00fe3ae496aab2eec1740dad8011cc66e7e46c4132c9986dbe318d272e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.11/nylas_3.1.11_linux_amd64.tar.gz"
      sha256 "af6ab10848d4e5370882f1edd6bf1f6ac244e5f98b5f11c9d8aed5e92a34d56f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.11/nylas_3.1.11_linux_arm64.tar.gz"
      sha256 "c70a72630096c76e9cb23d838d2fb39b79182be2dabb8d9cae1cf03563958e15"
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
