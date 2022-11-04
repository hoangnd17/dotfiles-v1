cask "jsontomodel" do
    version "1.5"
    url "https://github.com/chanonly123/Json-Model-Generator/releases/download/v1.5/JsonToModel.zip"
    name "JsonToModel"
    desc "Template based highly customisable MacOS application for generating JSON classes"
    homepage "https://github.com/chanonly123/Json-Model-Generatorr"
  
    auto_updates true
    depends_on macos: ">= :catalina"
  
    app "JSONToModel.app"
end