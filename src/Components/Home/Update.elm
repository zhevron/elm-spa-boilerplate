module Components.Home.Update exposing (update)

import Components.Home.Msg exposing (Msg(..))
import Model exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []
