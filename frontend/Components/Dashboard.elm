module Components.Dashboard where

import Html exposing (Html, div, h1, text, p, ul, li, a, button)
import Html.Attributes exposing (class, href, classList)
import Html.Events exposing (onClick)
import Effects exposing (Effects)
import Http
import Json.Decode exposing
  ( Decoder, decodeValue, succeed, string, list, int, (:=)
  )
import Json.Decode.Extra exposing ((|:))
import Task


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , categories : Maybe (List Category)
  , songs : Maybe (List Song)
  , unfoldedCategoryId : Maybe CategoryId
  }

type alias Category =
  { id : CategoryId
  , name : String
  }

type alias CategoryId =
  Int

type alias Song =
  { number : String
  , title : String
  }

init : { title: String, subtitle: String } -> (Model, Effects Action)
init { title, subtitle } =
  ( { title = title
    , subtitle = subtitle
    , categories = Just []
    , songs = Just []
    , unfoldedCategoryId = Nothing
    }
  , Effects.batch
    [ getCategories
    , getSongs
    ]
  )


-- UPDATE

type Action
  = RenderCategories (Maybe (List Category))
  | CacheSongs (Maybe (List Song))
  | UnfoldCategory CategoryId
  | FoldCategories

update : Action -> Model -> (Model, Effects Action)
update action model =
  let
    static model' =
      (model', Effects.none)

  in
    static <| case action of
      RenderCategories categories ->
        { model
        | categories = categories
        }

      CacheSongs songs ->
        { model
        | songs = songs
        }

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
    isCurrent category =
      model.unfoldedCategoryId == Just category.id

    renderCategory category =
      li
        [ classList
          [ ("dashboard’s-category", True)
          , ("dashboard’s-category·unfolded", isCurrent category)
          ]
        ]
        [ button
          [ class
            <| "dashboard’s-button"
            ++ " dashboard’s-category-title"
          , onClick address <|
            if isCurrent category
              then FoldCategories
              else UnfoldCategory category.id
          ]
          [ text
            <| toString category.id
            ++ ". "
            ++ category.name
          ]
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
            [ text
              <| "Oops! We run into a problem when trying to fetch "
              ++ "song categories. Try clearing the cache and reloading "
              ++ "the page. If that doesn’t work, "
            , a [ href "https://github.com/magnificat/magnificat.surge.sh/issues" ]
                [ text "let us know"
                ]
            , text "!"
            ]

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
