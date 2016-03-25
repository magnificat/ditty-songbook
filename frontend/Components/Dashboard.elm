module Components.Dashboard where

import Html exposing (Html, div, h1, text, p, ul, li, a, button, span)
import Html.Attributes exposing (class, href, classList)
import Html.Events exposing (onClick)


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , categories : Maybe (List Category)
  , songs : Maybe (List SongData)
  , unfoldedCategoryId : Maybe CategoryId
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
  }

init :
  { a
  | title : String
  , subtitle : String
  } -> Model
init stub =
  { title = stub.title
  , subtitle = stub.subtitle
  , categories = Just []
  , songs = Just []
  , unfoldedCategoryId = Nothing
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

update : Action -> Model -> Model
update action model =
  case action of
    UnfoldCategory id ->
      { model
      | unfoldedCategoryId = Just id
      }

    FoldCategories ->
      { model
      | unfoldedCategoryId = Nothing
      }


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let
    isUnfolded category =
      model.unfoldedCategoryId == Just category.id

    categoryButton category =
      button
        [ class
          <| "dashboard’s-button"
          ++ " dashboard’s-category-title"
        , onClick address <|
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
        [ class "dashboard’s-song"
        ]
        [ button
          [ class "dashboard’s-button"
          ]
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
      case model.categories of
        Just categories ->
          ul
            [ class "dashboard’s-categories"
            ]
            <| List.map renderCategory categories

        Nothing ->
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
