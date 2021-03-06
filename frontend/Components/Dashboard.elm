module Components.Dashboard where

import Html exposing (Html, div, h1, text, p, ul, li, a, button, span)
import Html.Attributes exposing (class, href, classList)
import Html.Events exposing (onClick)
import BabyLibs.PushState as PushState
import Effects exposing (Effects)


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , categories : Maybe (List Category)
  , songs : Maybe (List SongData)
  , unfoldedCategoryId : Maybe CategoryId
  , errorMessage : Maybe (List Html)
  , currentSongSlug : Maybe Slug
  }

type alias Category =
  { id : CategoryId
  , name : String
  }

type alias CategoryId =
  Int

type alias SongData =
  { number : String
  , title : String
  , category : CategoryId
  , slug : Slug
  }

type alias Slug =
  String

init :
  { title : String
  , subtitle : String
  , currentSongSlug : Maybe Slug
  } -> Model
init { title, subtitle, currentSongSlug } =
  { title = title
  , subtitle = subtitle
  , categories = Just []
  , songs = Just []
  , unfoldedCategoryId = Nothing
  , errorMessage = Nothing
  , currentSongSlug = currentSongSlug
  }

injectCategories : Maybe (List Category) -> Model -> Model
injectCategories categories model =
  { model
  | categories = categories
  }

injectSongs : Maybe (List SongData) -> Model -> Model
injectSongs songs model =
  { model
  | songs = songs
  }


-- UPDATE

type Action
  = UnfoldCategory CategoryId
  | FoldCategories
  | UrlChange PushState.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
  let
    model =
      case action of
        UnfoldCategory id ->
          { model
          | unfoldedCategoryId = Just id
          }

        FoldCategories ->
          { model
          | unfoldedCategoryId = Nothing
          }

        _ ->
          model

    effects =
      case action of
        UrlChange pushStateAction ->
          Effects.map UrlChange
            <| PushState.update pushStateAction
        _ ->
          Effects.none

  in
    (model, effects)

appSignal : Signal Action
appSignal =
  Signal.map UrlChange PushState.appSignal


-- VIEW

type alias Context =
  { actions : Signal.Address Action
  , focusDisplay : Signal.Address ()
  }

view : Context -> Model -> Html
view context model =
  let
    isUnfolded category =
      model.unfoldedCategoryId == Just category.id

    categoryButton category =
      button
        [ class
          <| "dashboard’s-button"
          ++ " dashboard’s-category-title"
        , onClick context.actions <|
          if isUnfolded category
            then FoldCategories
            else UnfoldCategory category.id
        ]
        [ text
          <| toString category.id
          ++ ". "
          ++ category.name
        ]

    renderSongs category =
      case model.songs of
        Just songs ->
          ul
            []
            ( List.filter (\song -> song.category == category.id) songs
                |> List.map renderSong
            )

        Nothing ->
          p
            [ class "dashboard’s-song dashboard’s-button"
            ]
            <| errorText "loading songs"

    errorText message =
      [ text
        <| "Oops! We run into a problem when " ++ message ++ ". Try clearing "
        ++ "the cache and reloading the page. If that doesn’t work, "
      , a [ href "https://github.com/magnificat/magnificat.surge.sh/issues" ]
          [ text "let us know"
          ]
      , text "!"
      ]

    renderSong song =
      li
        [ classList
          [ ("dashboard’s-song",
              True)
          , ("dashboard’s-song·current",
              model.currentSongSlug == Just song.slug)
          ]
        , onClick context.focusDisplay ()
        ]
        [ a
          (  class "dashboard’s-button"
          :: PushState.href ("/" ++ song.slug)
          )
          [ text <| song.number ++ " " ++ song.title
          ]
        ]

    renderCategory category =
      li
        [ classList
          [ ("dashboard’s-category", True)
          , ("dashboard’s-category·unfolded", isUnfolded category)
          ]
        ]
        [ categoryButton category
        , renderSongs category
        ]

    categoriesOrError =
      case (model.errorMessage, model.categories) of
        (Just errorContents, _) ->
          p
            [ class "dashboard’s-categories"
            ]
            errorContents

        (Nothing, Just categories) ->
          ul
            [ class "dashboard’s-categories"
            ]
            <| List.map renderCategory categories

        (Nothing, Nothing) ->
          p
            [ class "dashboard’s-categories"
            ]
            <| errorText "trying to fetch song categories"

  in
    div
      [ class "dashboard"
      ]
      [ h1
        [ class "dashboard’s-title"
        ]
        [ text model.title
        ]
      , p
        [ class "dashboard’s-subtitle"
        ]
        [ text model.subtitle
        ]
      , categoriesOrError
      ]
