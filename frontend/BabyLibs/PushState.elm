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
  let
    updatePath _ =
      UpdatePath url |> Signal.message actions.address

    ignoreValue =
      Json.succeed Nothing

    killEvent =
      { stopPropagation = True, preventDefault = True }

  in
    [ Html.Attributes.href url
    , onWithOptions "click" killEvent ignoreValue updatePath
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
      let
        toNoOp _ = NoOp
      in
        History.setPath path |> Effects.task |> Effects.map toNoOp
