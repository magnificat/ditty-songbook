import Components.Songbook as Songbook exposing
  ( init, update, view, Action(Navigate), Route(DisplaySong, Home, NotFound)
  )
import StartApp
import Effects exposing (Never)
import Task
import Html
import Time exposing (second)

port initialPath : String

app : StartApp.App Songbook.Model
app =
  StartApp.start
    { init = init
      { title = "magnificat"
      , subtitle = "Śpiewnik Equipes Notre Dame"
      , route = DisplaySong "chwalcie-pana-narody"
      }
    , update = update
    , view = view
    , inputs =
      [ Signal.map
        (\seconds -> if truncate(seconds / second) % 2 == 0
          then Navigate Home
          else Navigate NotFound
        )
        <| Time.every second
      ]
    }

main : Signal Html.Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
