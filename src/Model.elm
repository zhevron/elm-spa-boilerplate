module Model exposing (Model, initialModel)

import Navigation

import Route exposing (Route)

type alias Model =
    { history : List (Maybe Route)
    , content : String
    }

initialModel : Navigation.Location -> Model
initialModel location =
    { history = [ Route.fromLocation location ]
    , content = "Hello world"
    }
