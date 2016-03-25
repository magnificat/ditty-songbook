module Components.Songbook where

import Html exposing (Html, div, h1, text, p)
import Html.Attributes exposing (class)
import Effects exposing (Effects)
import Signal
import Effects exposing (Effects)
import Http
import Json.Decode exposing
  ( Decoder, decodeValue, succeed, string, list, int, (:=)
  )
import Json.Decode.Extra exposing ((|:))
import Task

import Components.Dashboard as Dashboard exposing (Category, Song)
import Components.Display as Display


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , categories : Maybe (List Category)
  , songs : Maybe (List Song)
  , dashboard : Dashboard.Model
  }

init :
  { title : String
  , subtitle : String
  } -> (Model, Effects Action)
init stub =
  let
    model =
      { title = stub.title
      , subtitle = stub.subtitle
      , categories = Nothing
      , songs = Nothing
      , dashboard = Dashboard.init stub
      }

    effects =
      Effects.batch
        [ getCategories
        , getSongs
        ]

  in
    (model, effects)


-- UPDATE

type Action
  = RenderCategories (Maybe (List Category))
  | CacheSongs (Maybe (List Song))
  | DashboardAction Dashboard.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  ( case action of
      RenderCategories categories ->
        { model
        | categories = categories
        , dashboard = Dashboard.injectCategories categories model.dashboard
        }

      CacheSongs songs ->
        { model
        | songs = songs
        , dashboard = Dashboard.injectSongs songs model.dashboard
        }

      DashboardAction dashboardAction ->
        { model
        | dashboard = Dashboard.update dashboardAction model.dashboard
        }

  , Effects.none
  )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "songbook"
    ]
    [ Dashboard.view (Signal.forwardTo address DashboardAction) model.dashboard
    , Display.view
    ]


-- EFFECTS

getCategories : Effects Action
getCategories =
  Http.get (list category) "/api/categories.json"
    |> Task.toMaybe
    |> Task.map RenderCategories
    |> Effects.task

category : Decoder Category
category =
  succeed Category
    |: ("id" := int)
    |: ("name" := string)

getSongs : Effects Action
getSongs =
  Http.get (list song) "/api/songs.json"
    |> Task.toMaybe
    |> Task.map CacheSongs
    |> Effects.task

song : Decoder Song
song =
  succeed Song
    |: ("number" := string)
    |: ("title" := string)
    |: ("category" := int)
