module App.Msg exposing (Msg(..))

import Navigation
import Ui.App

import App.Route exposing (Route)
import Views.Home.Msg as Home

type Msg
    = App Ui.App.Msg
    | HomeMsg Home.Msg
    | NavigateTo Route
    | UrlChange Navigation.Location
    | NoOp
