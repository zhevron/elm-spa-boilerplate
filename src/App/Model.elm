module App.Model exposing (Model, initialModel)

import Navigation

import App.Route exposing (Route)

type alias Model =
    { history : List (Maybe Route)
    , content : String
    }

initialModel : Navigation.Location -> Model
initialModel location =
    { history = [ App.Route.fromLocation location ]
    , content = "Hello world"
    }
