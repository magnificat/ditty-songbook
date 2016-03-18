module Components.Display where

import Html exposing ( Html, div )
import Html.Attributes exposing ( class )


-- MODEL

type alias Model =
  ()

init : Model -> Model
init model =
  model


-- UPDATE

type alias Action =
  ()

update : Action -> Model -> Model
update action model =
  model


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "display" ] []
