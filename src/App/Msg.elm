module App.Msg exposing (Msg(..))

import Navigation

import App.Route exposing (Route)
import Views.Home.Msg as Home

type Msg
    = HomeMsg Home.Msg
    | NavigateTo Route
    | UrlChange Navigation.Location
    | NoOp