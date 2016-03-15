module App where

import Html exposing ( Html, div, h1, text, p )
import Html.Attributes exposing ( class )


-- MODEL

type alias Model =
  { appName : String
  , subtitle : String
  }

init : Model -> Model
init model = model


-- UPDATE

type alias Action
  = Maybe ()

update : Action -> Model -> Model
update action model = model


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "app" ]
    [ div [ class "dashboard" ]
      [ h1 [ class "dashboard’s-title" ]
        [ text model.appName
        ]
      , p [ class "dashboard’s-subtitle" ]
        [ text model.subtitle
        ]
      ]

    , div [ class "display" ]
      []
    ]
