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

import Components.Dashboard as Dashboard exposing (Category, CategoryId)
import Components.Display as Display exposing (SongBlock)


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , categories : Maybe (List Category)
  , songs : Maybe (List Song)
  , dashboard : Dashboard.Model
  , display : Display.Model
  }

type alias Song =
  { number : String
  , title : String
  , category : CategoryId
  , slug : String
  , blocks : List SongBlock
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
      , display = Display.Model Nothing
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
  = UpdateSong (Maybe String)
  | NoOp
  | RenderCategories (Maybe (List Category))
  | CacheSongs (Maybe (List Song))
  | DashboardAction Dashboard.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  let
    model = case action of
      RenderCategories categories ->
        { model
        | categories = categories
        , dashboard = Dashboard.injectCategories categories model.dashboard
        }

      CacheSongs songs ->
        { model
        | songs = songs
        , dashboard = Dashboard.injectSongs
          (Maybe.map (List.map toSongData) songs)
          model.dashboard
        }

      DashboardAction dashboardAction ->
        { model
        | dashboard = Dashboard.update dashboardAction model.dashboard
        }

    toSongData song =
      { number = song.number
      , title = song.title
      , category = song.category
      }

  in
    (model, Effects.none)


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "songbook"
    ]
    [ Dashboard.view (Signal.forwardTo address DashboardAction) model.dashboard
    , Display.view model.display
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
    |: ("slug" := string)
    |: ("blocks" := list songBlock)

songBlock : Decoder SongBlock
songBlock =
  succeed SongBlock
    |: ("type" := string)
    |: ("lyrics" := string)
