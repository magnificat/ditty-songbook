import Components.Songbook as Songbook exposing
  ( init, update, view, Action(Navigate), Route(DisplaySong, Home, NotFound)
  )
import StartApp
import Effects exposing (Never)
import Task
import Html
import RouteParser exposing (Matcher, static, dyn1, string)
import History

port initialPath : String

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
    , inits =
      [ routeChanges
      ]
    }

routeMatchers : List (Matcher Route)
routeMatchers =
  [ static Home "/"
  , dyn1 DisplaySong "/" string ""
  ]

routeChanges : Signal Songbook.Action
routeChanges =
  let
    getRoute path =
      Maybe.withDefault NotFound
        <| RouteParser.match routeMatchers path
  in
    Signal.map (Navigate << getRoute) History.path

main : Signal Html.Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
