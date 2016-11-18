module Components.Home.View exposing (view)

import Html exposing (Html, text)

import Components.Home.Msg exposing (Msg(..))
import Model exposing (Model)

view : Model -> Html Msg
view model =
    text model.content
