import Components.Songbook exposing (init, update, view)
import StartApp
import Html
import Effects exposing (Never)
import Task

app =
  StartApp.start
    { init = init
      { title = "magnificat"
      , subtitle = "Śpiewnik Equipes Notre Dame"
      }
    , update = update
    , view = view
    , inputs = []
    }

main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
