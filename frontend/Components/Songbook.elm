module Components.Songbook where

import Html exposing ( Html, div, h1, text, p )
import Html.Attributes exposing ( class )
import Effects exposing (Effects)
import Signal
import Http
import Json.Decode as Json
import Task

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
        []
      }

  in
    ( model
    , getCategories
    )


-- UPDATE

type Action
  = RenderCategories (Maybe String)
  | DashboardAction Dashboard.Action
  | DisplayAction Display.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  let
    newModel =
      case action of
        RenderCategories (Just response) ->
          { model
          | dashboard = Dashboard.Model model.title model.subtitle
            [{ id = 99, name = response }]
          }

        _ ->
          newModel
  in
    ( newModel
    , Effects.none
    )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "songbook" ]
    [ Dashboard.view (Signal.forwardTo address DashboardAction) model.dashboard
    , Display.view (Signal.forwardTo address DisplayAction) ()
    ]


-- EFFECTS

getCategories =
  let
    url =
      Http.url "/api/categories.json" []

  in
    Http.get Json.string url
      |> Task.toMaybe
      |> Task.map RenderCategories
      |> Effects.task
