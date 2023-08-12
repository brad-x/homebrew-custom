class Libangle < Formula
  desc "Conformant OpenGL ES implementation for Windows, Mac, Linux, iOS and Android"
  homepage "https://github.com/google/angle"
  url "https://github.com/google/angle.git", using: :git, revision: "66ab9240d3a5969258e65f2f7fe453e83299aa30"
  version "20211212.1"
  license "BSD-3-Clause"

  depends_on "meson" => :build
  depends_on "ninja" => :build

  resource "depot_tools" do
    url "https://chromium.googlesource.com/chromium/tools/depot_tools.git", revision: "5da65ec20db9b17b03420d928240092e5955a769"
  end

  def install
    mkdir "build" do
      resource("depot_tools").stage do
        path = PATH.new(ENV["PATH"], Dir.pwd)
        with_env(PATH: path) do
          Dir.chdir(buildpath)
          ENV["DEPOT_TOOLS_UPDATE"] = "0"

          # We run this rather than scripts/bootstrap.py
          # so that we can set the cache-dir since depot-tools pulls in a lot!
          system "gclient", "config",
                 "--name", "change2dot",
                 "--unmanaged",
                 "--cache-dir", "#{HOMEBREW_CACHE}/gclient_cache",
                 "-j", ENV.make_jobs,
                 "https://chromium.googlesource.com/angle/angle.git"
          content = File.read(".gclient")
          content = content.gsub(/change2dot/, ".")
          content += "target_os = [ 'android' ]"
          File.open(".gclient", "w") { |file| file.puts content }
          system "gclient", "sync", "-j", ENV.make_jobs

          # This fixes relocation failing with HeaderPadError in
          # replace_command in macho_file.rb
          system "sed", "-i", "-e", "1228i\\
          \"-Wl,-headerpad_max_install_names\",
          ", "BUILD.gn"
          system "gn", "gen", \
                 "--args=is_debug=false", \
                 "./angle_build"
          system "ninja", "-C", "angle_build"
          lib.install "angle_build/libEGL.dylib"
          lib.install "angle_build/libGLESv2.dylib"
          include.install Pathname.glob("include/*")
        end
      end
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libangle`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
