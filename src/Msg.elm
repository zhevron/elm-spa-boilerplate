module Msg exposing (Msg(..))

import Navigation

import Components.Home.Msg
import Route exposing (Route) 

type Msg
    = HomeMsg Components.Home.Msg.Msg
    | NavigateTo Route
    | UrlChange Navigation.Location
    | NoOp
