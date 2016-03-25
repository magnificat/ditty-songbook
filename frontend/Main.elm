import Router exposing ( init, update, view )
import StartApp
import Effects exposing ( Never )
import Task
import Html

port initialPath : String

app : StartApp.App Router.Model
app =
  StartApp.start
    { init = init
      { title = "magnificat"
      , subtitle = "Śpiewnik Equipes Notre Dame"
      , initialPath = initialPath
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
