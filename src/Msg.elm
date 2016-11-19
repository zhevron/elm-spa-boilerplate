module Msg exposing (Msg(..))

import Navigation

import Views.Home.Msg
import Route exposing (Route) 

type Msg
    = HomeMsg Views.Home.Msg.Msg
    | NavigateTo Route
    | UrlChange Navigation.Location
    | NoOp
