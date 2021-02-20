(declare-project
  :name "speed-series"
  :description "Internet speed monitoring application"
  :dependencies ["json"
                 "https://github.com/pyrmont/testament"
                 "https://github.com/andrewchambers/janet-sh"
                 "https://github.com/joy-framework/db"]
  :author "Daniel Schleindlsperger"
  :license "MIT"
  :url "https://github.com/danielschleindlsperger/speed-series"
  :repo "git+https://github.com/danielschleindlsperger/speed-series")

(declare-executable
 :name "speed-series"
 :entry "src/main.janet")

(phony "testw" []
  (os/shell "find . -name '*.janet' | entr -r -d jpm test"))

(phony "dev" []
  (os/shell "find . -name '*.janet' | entr -r -d janet src/main.janet"))
