module Components.Display where

import Html exposing (Html, div, text, p, br)
import Html.Attributes exposing (class)
import String


-- MODEL

type alias Model =
  { currentSong : Maybe Song
  }

type alias Song =
  { blocks : List SongBlock
  }

type alias SongBlock =
  { lyrics : String
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
      in p []
        <| List.map renderLine lines

    renderLine line =
      div [] [text line]

  in
    div
      [ class "display"
      ]
      displayContents
