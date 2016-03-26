import Components.Songbook as Songbook exposing
  ( init, update, view, Route(DisplaySong)
  )
import StartApp
import Effects exposing (Never)
import Task
import Html

port initialPath : String

app : StartApp.App Songbook.Model
app =
  StartApp.start
    { init = init
      { title = "magnificat"
      , subtitle = "Śpiewnik Equipes Notre Dame"
      , route = DisplaySong "przybadz-plomieniu"
      }
    , update = update
    , view = view
    , inputs = []
    }

main : Signal Html.Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
