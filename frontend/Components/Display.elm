module Components.Display where

import Html exposing (Html, div, text, p, br)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (onClick)
import String
import Time exposing (Time)
import Effects exposing (Effects)


-- MODEL

type alias Model =
  { currentSong : Maybe SongContent
  , mode : Mode
  , animationState : AnimationState
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
    }

dashboardWidth :
  { width : Int
  , rootFontSize : Int
  }
dashboardWidth =
  { width = 400
  , rootFontSize = 16
  }
  -- TODO: This should come from elm-styles.

init : Model
init =
  { currentSong = Nothing
  , mode = ShiftedAway
  , animationState = Nothing
  }


-- UPDATE

type Action
  = ShiftAway
  | Focus
  | Tick TargetMode Time

type alias TargetMode =
  Mode

update : Action -> Model -> (Model, Effects Action)
update action model =
  case (action, model.animationState, model.mode) of
    (ShiftAway, Nothing, InFocus) ->
      ( model
      , Effects.tick <| Tick ShiftedAway
      )

    (Focus, Nothing, ShiftedAway) ->
      ( model
      , Effects.tick <| Tick InFocus
      )

    (Tick targetMode clockTime, _, _) ->
      let
        newElapsedTime =
          case model.animationState of
            Nothing ->
              0

            Just { previousClockTime, elapsedTime } ->
              elapsedTime + (clockTime - previousClockTime)

        duration =
          Time.second
      in
        if newElapsedTime > duration
          then
            ( { model
              | mode = targetMode
              , animationState = Nothing
              }
            , Effects.none
            )

          else
            ( { model
              | animationState = Just
                { previousClockTime = clockTime
                , elapsedTime = newElapsedTime
                }
              }
            , Effects.tick <| Tick targetMode
            )

    _ ->
      (model, Effects.none)


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

    leftMarginInPixels =
      case (model.mode, model.animationState) of
        (InFocus, Nothing) ->
          0

        (ShiftedAway, Nothing) ->
          toFloat dashboardWidth.width

        (_, Just _) ->
          (toFloat dashboardWidth.width) / 2
  in
    div
      [ class "display’s-wrapper"
      ]
      [ div
        [ class "display"
        , style
            [ ( "margin-left"
              , toString
                  (leftMarginInPixels / toFloat dashboardWidth.rootFontSize)
                ++ "rem"
              )
            ]
        , onClick address ShiftAway
        ]
        displayContents
      ]
