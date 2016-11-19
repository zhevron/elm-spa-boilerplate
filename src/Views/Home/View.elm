module Views.Home.View exposing (view)

import Html exposing (Html, text)

import App.Model exposing (Model)
import Views.Home.Msg exposing (Msg(..))

view : Model -> Html Msg
view model =
    text model.content
