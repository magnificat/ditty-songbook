module Components.Dashboard where

import Html exposing ( Html, div, h1, text, p, ul, li )
import Html.Attributes exposing ( class )


-- MODEL

type alias Model =
  { title : String
  , subtitle : String
  , categories : List Category
  }

type alias Category =
  { id : Int
  , name : String
  }


-- UPDATE

type alias Action
  = ()

update : Action -> Model -> Model
update action model =
  model


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
