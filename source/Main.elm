module Main exposing (main)

import Navigation

import App.Model exposing (Model, initialModel)
import App.Msg exposing (Msg(..))
import App.Update exposing (update)
import App.View exposing (view)

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
