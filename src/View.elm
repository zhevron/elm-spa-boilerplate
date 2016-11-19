module View exposing (view)

import Html exposing (Html, text)

import Views.Home.View
import Model exposing (Model)
import Msg exposing (Msg(..))
import Route exposing (Route(..))

view : Model -> Html Msg
view model =
    viewForRoute model

viewForRoute : Model -> Html Msg
viewForRoute model =
    let
        route =
            case List.head model.history of
                Just route ->
                    route
                
                Nothing ->
                    Nothing
    in
        case route of
            Just Home ->
                Html.map HomeMsg (Views.Home.View.view model)
            
            Nothing ->
                text "404"
