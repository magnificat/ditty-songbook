import Components.Songbook as Songbook exposing
  ( init, update, view, Route(Home)
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
      , route = Home
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
