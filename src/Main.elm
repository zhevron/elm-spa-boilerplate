module Main exposing (main)

import Navigation

import Model exposing (Model, initialModel)
import Msg exposing (Msg(..))
import Update exposing (update)
import View exposing (view)

init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    (initialModel location) ! []

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
