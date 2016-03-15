module App where

import Html exposing ( Html, div )
import Html.Attributes exposing ( class )


-- MODEL

type alias Model =
  Maybe ()

init : Model
init =
  Nothing


-- UPDATE

type alias Action
  = Maybe ()

update : Action -> Model -> Model
update action model = model


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "app"
    ]
    []
