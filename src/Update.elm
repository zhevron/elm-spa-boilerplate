module Update exposing (update)

import Navigation

import Views.Home.Update as Home
import Model exposing (Model)
import Msg exposing (Msg(..))
import Route

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg subMsg ->
            let
                (newModel, cmd) = Home.update subMsg model
            in
                (newModel, Cmd.map HomeMsg cmd)
        
        NavigateTo route ->
            let
                url = Route.urlFor route
            in
                (model, Navigation.newUrl url)
        
        UrlChange location ->
            let
                history =
                    (Route.fromLocation location) :: model.history
            in
                Debug.log location.hash
                { model | history = history } ! []
        
        NoOp ->
            model ! []
