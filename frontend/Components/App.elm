module Components.App where

import Html exposing ( Html, div, h1, text, p )
import Html.Attributes exposing ( class )
import Effects exposing (Effects)
import Signal

import Components.Dashboard as Dashboard
import Components.Display as Display


-- MODEL

type alias Model =
  { appName : String
  , subtitle : String
  }

init : Model -> (Model, Effects Action)
init model =
  ( model
  , Effects.none
  )


-- UPDATE

type Action
  = DashboardAction Dashboard.Action
  | DisplayAction Display.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  ( model
  , Effects.none
  )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "app" ]
    [ Dashboard.view (Signal.forwardTo address DashboardAction) model
    , Display.view (Signal.forwardTo address DisplayAction) ()
    ]
