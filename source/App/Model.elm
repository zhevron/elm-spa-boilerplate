module App.Model exposing (Model, initialModel)

import Navigation
import Ui.App

import App.Route exposing (Route)

type alias Model =
    { app : Ui.App.Model
    , history : List (Maybe Route)
    , content : String
    }

initialModel : Navigation.Location -> Model
initialModel location =
    { app = Ui.App.init
    , history = [ App.Route.fromLocation location ]
    , content = "Hello world"
    }
