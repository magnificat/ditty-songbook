module Components.Dashboard where

import Html exposing ( Html, div, h1, text, p, ul, li )
import Html.Attributes exposing ( class )
import Effects exposing ( Effects )
import Http
import Json.Decode exposing ( Decoder, decodeValue, succeed, string, list, int, (:=) )
import Task


-- MODEL

type alias Category =
  { id : Int
  , name : String
  }

type alias Categories =
  List Category

type alias Model =
  { title : String
  , subtitle : String
  , categories : Categories
  }

init : { title: String, subtitle: String } -> (Model, Effects Action)
init { title, subtitle } =
  ( { title = title
    , subtitle = subtitle
    , categories = []
    }
  , getCategories
  )


-- UPDATE

type Action
  = RenderCategories (Maybe Categories)

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    RenderCategories (Just categories) ->
      ( { model
        | categories = categories
        }
      , Effects.none
      )

    RenderCategories Nothing ->
      ( { model
        | categories = [
          { id = 0
          , name = "(failed to load categories!)"
          }]
        }
      , Effects.none
      )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let
    renderCategory category =
      li [ class "dashboard’s-category" ]
        [ text
          <| toString category.id
          ++ ". "
          ++ category.name
        ]

  in
    div [ class "dashboard" ]
      [ h1 [ class "dashboard’s-title" ]
        [ text model.title
        ]
      , p [ class "dashboard’s-subtitle" ]
        [ text model.subtitle
        ]
      , ul [ class "dashboard’s-categories" ]
        <| List.map renderCategory model.categories
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
  Json.Decode.object2 Category
    ("id" := int)
    ("name" := string)
