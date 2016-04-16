module Components.Display where

import Html exposing (Html, div, text, p, br)
import Html.Attributes exposing (class, classList)
import String


-- MODEL

type alias Model =
  { currentSong : Maybe SongContent
  }

type alias SongContent =
  { blocks : List SongBlock
  }

type alias SongBlock =
  { blockType : String
  , lyrics : String
  }

init : Model
init =
  { currentSong = Nothing
  }


-- VIEW

view : Model -> Html
view model =
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

  in
    div
      [ class "display’s-wrapper"
      ]
      [ div
        [ class "display"
        ]
        displayContents
      ]
