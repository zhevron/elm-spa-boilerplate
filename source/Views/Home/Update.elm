module Views.Home.Update exposing (update)

import App.Model exposing (Model)
import Views.Home.Msg exposing (Msg(..))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []
