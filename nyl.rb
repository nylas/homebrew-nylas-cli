# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Nyl < Formula
  desc "Nylas Command Line Utility"
  homepage "https://nylas.com"
  version "1.0.0-preview3"
  bottle :unneeded
  depends_on :macos

  on_macos do
    if Hardware::CPU.intel?
      url "https://download.nylas.com/nylas-cli/v1.0.0-preview3/nylas-cli_1.0.0-preview3_darwin_amd64.tar.gz"
      sha256 "195ad980633901b640c927593198e51e0dc3b4af1eac5f7036f66d797eaa6219"
    end
  end

  def install
    bin.install "nyl"
  end
end
