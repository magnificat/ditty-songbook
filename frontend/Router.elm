module Router where

import RouteParser exposing (Matcher, dyn1, static, string, match)
import Effects exposing (Effects)
import Html exposing (Html)

import Components.Songbook as Songbook

type Route
  = TrailingSlash String
  | Home
  | SongSlug String

routes : List (Matcher Route)
routes =
  [ dyn1
    TrailingSlash "" string "/"

  , static
    Home ""

  , dyn1
    SongSlug "/" string ""
  ]


-- MODEL

type alias Model =
  { currentRoute : Maybe Route
  , songbook : Songbook.Model
  }

init :
  { title : String
  , subtitle : String
  , initialPath : String
  } -> (Model, Effects Action)
init stub =
  let
    (songbook, songbookFx) =
      Songbook.init stub

    model =
      { currentRoute = match routes stub.initialPath
      , songbook = songbook
      }

  in
    ( model
    , Effects.map SongbookAction songbookFx
    )


-- UPDATE

type Action
  = ChangeRoute String
  | SongbookAction Songbook.Action
  | NoOp

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    ChangeRoute path ->
      ( { model
        | currentRoute = match routes path
        }
      , Effects.none
      )

    SongbookAction action' ->
      let
        (songbook, songbookFx) = Songbook.update action' model.songbook
      in
        ( { model | songbook = songbook }
        , Effects.map SongbookAction songbookFx
        )

    NoOp ->
      (model, Effects.none)


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  Songbook.view (Signal.forwardTo address SongbookAction) model.songbook
