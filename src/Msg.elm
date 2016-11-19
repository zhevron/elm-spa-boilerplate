module Msg exposing (Msg(..))

import Navigation

import Views.Home.Msg as Home
import Route exposing (Route) 

type Msg
    = HomeMsg Home.Msg
    | NavigateTo Route
    | UrlChange Navigation.Location
    | NoOp
