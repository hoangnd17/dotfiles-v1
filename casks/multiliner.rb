cask "multiliner" do
    version "1.1.0"
    url "https://github.com/aheze/Multiliner/raw/main/Multiliner.zip"
    name "Multiliner"
    desc "An Xcode source extension to expand lengthy lines"
    homepage "https://github.com/aheze/Multiliner"
  
    auto_updates true
    depends_on macos: ">= :catalina"
  
    app "Multiliner.app"
end