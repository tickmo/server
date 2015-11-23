# Server file. Provides routes and working with URLs.
import future, asyncdispatch, strutils ,sequtils, asyncdispatch, os
import jester, templates
import layouts

const
  DirName: string = "savedscreens/"
  format: string = "*.png"
type
  stringArray = seq[string]
var
  existScrens: stringArray

existScrens = @[]

for file in walkFiles(DirName & format):
  existScrens.add(file)

proc setImages(request: Request): string =
  var screenshots = request.formData["screenshots[]"]
  let fileName = screenshots.fields["filename"]

  try:
    writeFile(DirName & fileName, screenshots.body)
  except IOError:
    let msg = getCurrentExceptionMsg()
    echo "Screenshot $currentScreen not written to $folder " & msg

  existScrens.add(DirName & fileName)
  return ""

routes:
  post "/": resp setImages(request)
  get "/":  resp layouts.index(request, existScrens)

runForever()
