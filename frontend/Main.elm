import Components.App exposing (init, update, view)
import StartApp.Simple exposing (start)
import Html

main : Signal Html.Html
main =
  start
    { model = init
      { appName = "magnificat"
      , subtitle = "Śpiewnik Equipes Notre Dame"
      }
    , update = update
    , view = view
    }
