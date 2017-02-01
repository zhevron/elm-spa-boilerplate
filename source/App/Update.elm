module App.Update exposing (update)

import Navigation
import Ui.App

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))
import App.Route
import Views.Home.Update as Home

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        App subMsg ->
            let
                (app, effect) = Ui.App.update subMsg model.app
            in
                ({ model | app = app }, Cmd.map App effect)
        HomeMsg subMsg ->
            let
                (newModel, cmd) = Home.update subMsg model
            in
                (newModel, Cmd.map HomeMsg cmd)
        
        NavigateTo route ->
            let
                url = App.Route.urlFor route
            in
                (model, Navigation.newUrl url)
        
        UrlChange location ->
            let
                history =
                    (App.Route.fromLocation location) :: model.history
            in
                { model | history = history } ! []
        
        NoOp ->
            model ! []
