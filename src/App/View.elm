module App.View exposing (view)

import Html exposing (Html, text)

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))
import App.Route exposing (Route(..))
import Views.Home.View as Home

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
                Html.map HomeMsg (Home.view model)
            
            Nothing ->
                text "404"
