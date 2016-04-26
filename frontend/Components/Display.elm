module Components.Display where

import Html exposing (Html, div, text, p, br)
import Html.Attributes exposing (class, classList, property)
import Html.Events exposing (onClick, on)
import String
import Time exposing (Time)
import Effects exposing (Effects)
import Easing
import Json.Encode
import Json.Decode
import Response


-- MODEL

type alias Model =
  { currentSong : Maybe SongContent
  , mode : Mode
  , animationState : AnimationState
  , currentScrollOffset : Float
  }

type alias SongContent =
  { blocks : List SongBlock
  }

type alias SongBlock =
  { blockType : String
  , lyrics : String
  }

type Mode
  = ShiftedAway
  | InFocus

type alias AnimationState =
  Maybe
    { previousClockTime : Time
    , elapsedTime : Time
    , targetMode : Mode
    }

dashboardWidth : Float
dashboardWidth = 400
  -- TODO: This should come from elm-styles.

duration : Time
duration =
  500 * Time.millisecond

init : Model
init =
  { currentSong = Nothing
  , mode = ShiftedAway
  , animationState = Nothing
  , currentScrollOffset = dashboardWidth
  }


-- UPDATE

type Action
  = ShiftAway
  | Focus
  | Tick TargetMode Time
  | UpdateScrollOffset Float

type alias TargetMode =
  Mode

update : Action -> Model -> (Model, Effects Action)
update action model =
  case (action, model.animationState) of
    (ShiftAway, Nothing) ->
      ( model
      , Effects.tick <| Tick ShiftedAway
      )

    (Focus, Nothing) ->
      ( model
      , Effects.tick <| Tick InFocus
      )

    (Tick targetMode clockTime, _) ->
      let
        newElapsedTime =
          case model.animationState of
            Nothing ->
              0

            Just { previousClockTime, elapsedTime } ->
              elapsedTime + (clockTime - previousClockTime)
      in
        if newElapsedTime > duration
          then
            ( { model
              | mode = targetMode
              , animationState = Nothing
              , currentScrollOffset = case targetMode of
                InFocus -> dashboardWidth
                ShiftedAway -> 0
              }
            , Effects.none
            )

          else
            ( { model
              | animationState = Just
                { previousClockTime = clockTime
                , elapsedTime = newElapsedTime
                , targetMode = targetMode
                }
              }
            , Effects.tick <| Tick targetMode
            )

    (UpdateScrollOffset newOffset, Nothing) ->
      { model
      | currentScrollOffset = newOffset
      }
      |> Response.withNone


    _ ->
      model
      |> Response.withNone


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let
    displayContents =
      case model.currentSong of
        Nothing ->
          []

        Just song ->
          List.map renderSongBlock song.blocks

    renderSongBlock block =
      let
        lines = String.split "\n" block.lyrics
      in p
        [ classList
          [ ("display’s-song-block", True)
          , ("display’s-song-block·type»refrain", block.blockType == "refrain")
          ]
        ]
        <| List.map renderLine lines

    renderLine line =
      div [class "display’s-song-line"] [text line]

    leftScrollOffset =
      case (model.mode, model.animationState) of
        (InFocus, Nothing) ->
          dashboardWidth

        (ShiftedAway, Nothing) ->
          0

        (_, Just animationState) ->
          let
            to = case animationState.targetMode of
              InFocus ->
                dashboardWidth

              ShiftedAway ->
                0
          in
            Easing.ease
              Easing.easeInOutExpo
              Easing.float
              model.currentScrollOffset
              to
              duration
              animationState.elapsedTime
  in
    div
      [ class "display’s-wrapper"
      , property
        "scrollLeft"
        <| Json.Encode.float leftScrollOffset
      , on "scroll"
        (Json.Decode.at ["target", "scrollLeft"] Json.Decode.float)
        (\newOffset -> Signal.message address <| UpdateScrollOffset newOffset)
      ]
      [ div
        [ class "display"
        , onClick address ShiftAway
        ]
        displayContents
      ]
