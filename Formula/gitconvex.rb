class Gitconvex < Formula
  desc "Gitconvex - A Web UI client for git"
  homepage "https://gitconvex.com"
  url "https://github.com/neel1996/gitconvex/releases/download/2.1.1/gitconvex-v2.1.1-brew.tar.gz"
  sha256 "683C1927E750499CEC95B807E0491362A159757FAD0E951F678C7F20B3B5C74A"
  license "Apache-2.0"

  depends_on "go" => :build
  depends_on "libssh2"
  depends_on "libgit2"

  def print_lines(sym)
    $i = 0
    print "\n"
    while $i < 50 do
      print "#{sym}"
      $i += 1
    end
    print "\n"
  end

  def install
    # Current version will be updated every release
    version = "2.1.1"
    system "cp", "-rp", "./dist/", bin
    ENV["GOPATH"] = buildpath
    bin_path = buildpath/"src/github.com/neel1996/gitconvex-server"
    bin_path.install Dir["*"]
    cd bin_path do
      system "go", "build", "-v", "-o", bin/"gitconvex", "."
      print_lines("=")
      print "\n✅\tGitconvex server is successfully installed!"
      print "\n🖥️\tNow copy and run the following command to link the UI directory to the same path"
      print "\n"
      cmd = "ln -s #{HOMEBREW_PREFIX}/Cellar/gitconvex/#{version}/bin/gitconvex-ui #{HOMEBREW_PREFIX}/bin/"
      print_lines(">")
      print "\n#{cmd}\n"
      print_lines("<")
      print_lines("=")
    end
  end

  test do
    assert_match "2.1.1", shell_output("#{bin}/gitconvex --version")
  end
end
