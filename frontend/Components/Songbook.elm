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
init stub =
  let
    (dashboard, dashboardFx) =
      Dashboard.init stub

  in
    ( Model stub.title stub.subtitle dashboard
    , Effects.batch
        [ Effects.map DashboardAction dashboardFx
        ]
    )


-- UPDATE

type Action
  = DashboardAction Dashboard.Action
  | DisplayAction Display.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    DashboardAction dashboardAction ->
      let
        (dashboardModel, fx) =
          Dashboard.update dashboardAction model.dashboard

      in
        ( { model
          | dashboard = dashboardModel
          }
        , Effects.map DashboardAction fx
        )

    DisplayAction displayAction ->
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
