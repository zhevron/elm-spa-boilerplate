module Views.Home.View exposing (view)

import Html exposing (Html, text)

import Views.Home.Msg exposing (Msg(..))
import Model exposing (Model)

view : Model -> Html Msg
view model =
    text model.content
