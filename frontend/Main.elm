import Components.Songbook as Songbook exposing ( init, update, view )
import StartApp
import Effects exposing ( Never )
import Task
import Html

app : StartApp.App Songbook.Model
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

main : Signal Html.Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
