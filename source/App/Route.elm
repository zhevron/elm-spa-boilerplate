module App.Route exposing (Route(..), fromLocation, urlFor)

import Navigation
import UrlParser as Url exposing (top)

type Route
    = Home

parser : Url.Parser (Route -> a) a
parser =
    Url.oneOf
        [ Url.map Home top
        ]

fromLocation : Navigation.Location -> Maybe Route
fromLocation location =
    Url.parseHash parser location

urlFor : Route -> String
urlFor route =
    let
        url =
            case route of
                Home ->
                    "/"
    in
        "#" ++ url
