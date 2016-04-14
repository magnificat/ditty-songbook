module BabyLibs.PushState
  ( href, appSignal, update
  , Action
  )
  where

import Html exposing (Attribute)
import Html.Attributes
import Html.Events exposing (onWithOptions)
import Json.Decode as Json
import Signal exposing (Address)
import History
import Effects exposing (Effects)

href : String -> List Attribute
href url =
  [ Html.Attributes.href url
  , onWithOptions
      "click"
      { stopPropagation = True, preventDefault = True }
      (Json.succeed Nothing)
      (\_ -> Signal.message actions.address <| UpdatePath url)
  ]

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp

appSignal : Signal Action
appSignal =
  actions.signal

type Action
  = UpdatePath String
  | NoOp

update : Action -> Effects Action
update action =
  case action of
    NoOp ->
      Effects.none

    UpdatePath path ->
      Effects.map (\_ -> NoOp) <| Effects.task <| History.setPath path
