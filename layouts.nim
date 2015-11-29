# File with page layouts.
import templates, views, jester

# All screens layout
proc index*(request: Request, existScrens: seq[string]): string =
  tmpli  html"""
    <div class="list-screens">
      <div class="row">
        <ul>
          $for screen in existScrens {
            <li><a href="$screen" class="thumbnail"><img src="$screen" alt="screen not available"></a></li>
          }
        </div>
      </div>
    </div>
      """
  return views.allScreensView("Screenshots", result)
