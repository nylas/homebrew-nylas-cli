# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Nylas < Formula
  desc "Nylas Command Line Utility"
  homepage "https://nylas.com"
  version "1.0.0"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://download.nylas.com/nylas-cli/v1.0.0/nylas-cli_1.0.0_Darwin_x86_64.tar.gz"
      sha256 "7c8c8acb0a22bd72474b369305b573817d87282ec063995b060e4a372a60b42c"
    end
    if Hardware::CPU.arm?
      url "https://download.nylas.com/nylas-cli/v1.0.0/nylas-cli_1.0.0_Darwin_arm64.tar.gz"
      sha256 "c781ae4253c5d4d8fbacf8f1169002e4bffcc118222eb9db419913043135cfe4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://download.nylas.com/nylas-cli/v1.0.0/nylas-cli_1.0.0_Linux_x86_64.tar.gz"
      sha256 "4815aeb64a5aa25639bb85021f7705366910e0e67274126d1014e0d34a138fb4"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://download.nylas.com/nylas-cli/v1.0.0/nylas-cli_1.0.0_Linux_arm64.tar.gz"
      sha256 "2ae1421389274c39fa81964207c7d46d609a569a92a17b76d9994a031e1ac184"
    end
  end

  def install
    bin.install "nylas"
  end
end
