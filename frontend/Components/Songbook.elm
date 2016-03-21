module Components.Songbook where

import Html exposing ( Html, div, h1, text, p )
import Html.Attributes exposing ( class )
import Effects exposing (Effects)
import Signal

import Components.Dashboard as Dashboard
import Components.Display as Display


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , dashboard : Dashboard.Model
  }

init : { title : String, subtitle : String } -> (Model, Effects Action)
init { title, subtitle } =
  let
    model =
      { title = title
      , subtitle = subtitle
      , dashboard = Dashboard.Model title subtitle
        [ { id = 1, name = "One" }
        , { id = 2, name = "Two, a bit longer" }
        , { id = 3, name = "Three three" }
        , { id = 4, name = "Fourish" }
        , { id = 5, name = "Fifth but not least" }
        ]
      }

  in
    (model, Effects.none)


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
  div [ class "songbook" ]
    [ Dashboard.view (Signal.forwardTo address DashboardAction) model.dashboard
    , Display.view (Signal.forwardTo address DisplayAction) ()
    ]
