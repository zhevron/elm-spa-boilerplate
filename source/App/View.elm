module App.View exposing (view)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (id)
import Ui
import Ui.App
import Ui.Header

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))
import App.Route exposing (Route(..))
import Views.Home.View as Home

view : Model -> Html Msg
view model =
    Ui.App.view App model.app
        [ header
        , viewForRoute model
        ]

header : Html Msg
header =
    Ui.Header.view
        [ Ui.Header.title
            { text = "Elm SPA Boilerplate"
            , action = Just (NavigateTo Home)
            , link = Just "/"
            , target = "_self"
            }
        , Ui.spacer
        , Ui.Header.iconItem
            { text = "Action 1"
            , glyph = "bookmark"
            , action = Nothing
            , link = Nothing
            , side = "left"
            , target = "_self"
            }
        , Ui.Header.separator
        , Ui.Header.iconItem
            { text = "Action 2"
            , glyph = "bookmark"
            , action = Nothing
            , link = Nothing
            , side = "left"
            , target = "_self"
            }
        ]

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
