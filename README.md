# Elm SPA boilerplate

> Boilerplate example code for a single page application in Elm.

__DISCLAIMER:__ This is merely a test project for an SPA in Elm 0.18 to create a common architecture for my personal projects.

## Project Structure

```text
public/              -- Contains all static files.
  index.html         -- Entry point HTML page connecting the Elm and CSS code.
source/              -- Contains all the Elm source code.
  App/               -- Contains all application-wide modules.
    Model.elm        -- Defines the app model. Do not use view-specific models.
    Msg.elm          -- Defines app-wide messages. Use view-specific messages where possible.
    Route.elm        -- Defines the app routes as well as the URLs.
    Update.elm       -- Routes messages to the various views.
    View.elm         -- Handles the rendering of various views based on the route.
  Components/        -- Directory containing shared components.
    MyComponent.elm  -- Exposes only a view function.
  Views/             -- Contains all application views.
    Home/            -- Use a single directory per module/view. A module may have more than one view.
      Msg.elm        -- Defines view-specific messages.
      Update.elm     -- Handles messages for the view.
      View.elm       -- Contains one or more templates for this view.
  Main.elm           -- Contains the logic to start the app.
stylesheets/         -- Contains the CSS/SASS code.
  main.scss          -- Entry point CSS/SASS file automatically loaded in index.html.
```

## How can I link from one view to another?

To link from one view to another, make sure a route is defined in `src/App/Route.elm`. Ex:

```elm
module App.Route exposing (Route(..), fromLocation, urlFor)

import Navigation
import UrlParser as Url exposing (s, top)

type Route
    = Home
+   | Todos

parser : Url.Parser (Route -> a) a
parser =
    Url.oneOf
        [ Url.map Home top
+       , Url.map Todos (s "todos")
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
                  
+               Todos ->
+                   "/todos"
    in
        "#" ++ url

```

You can then link to the `Todos` route using `onClick`. Ex:

```elm
module Views.Home.View exposing (view)

import Html exposing (Html, a, text)
import Html.Events exposing (onClick)

import App.Model exposing (Model)
import App.Msg exposing (Msg(..))
import App.Route exposing (Route(..))

view : Model -> Html Msg
view model =
    a [ onClick (NavigateTo Todos) ] [ text "Todos" ]
``` 

## How do I add new pages?

1) Add new fields to the application-wide model in `src/App/Model.elm`. Ex:

```elm
module App.Model exposing (Model, Todo, initialModel)

import Navigation

import Route exposing (Route)

+ type alias Todo = 
+     { id : Int
+     , description : String
+     }

type alias Model =
    { history : List (Maybe Route)
    , content : String
+   , todos : List Todo
+   , nextId : Int
    }

initialModel : Navigation.Location -> Model
initialModel location =
    { history = [ Route.fromLocation location ]
    , content = "Hello world!"
+   , todos = []
+   , nextId = 0
    }
```

2) Create a new directory for your view under `src/Views/` (ex. `src/Views/Todos`)

3) Put your view-specific messages in `src/Views/<your view>/Msg.elm`. Ex:

```elm
module Views.Todos.Msg exposing (Msg(..))

type Msg
    = AddTodo String
    | RemoveTodo Int
```

4) Add an `update` function to process your new messages in `src/Views/<your view>/Update.elm`. Ex:

```elm
module Views.Todos.Update exposing (update)

import App.Model exposing (Model, Todo)
import Views.Todos.Msg exposing (Msg(..))

newTodo : Int -> String -> Todo
newTodo id description =
    { id = id
    , description = description
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddTodo todo ->
            { model | nextId = model.nextId + 1
            , todos = todos :: newTodo model.nextId todo
            } ! []
        
        RemoveTodo id ->
            { model | todos = List.filter (\t -> t.id /= id) model.todos } ! []
```

5) Add your view code in a separate module like `src/Views/<your view>/View.elm`. Ex:

```elm
module Views.Todos.View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)

import App.Model exposing (Model, Todo)
import Views.Todos.Msg exposing (Msg(..))

todoItem : Todo -> Html Msg
todoItem todo =
    li []
        [ text (toString todo.description)
        , a [ onClick (RemoveTodo todo.id) ] [ text "[Remove]" ]
        ]

todoList : Model -> Html Msg
todoList model =
    ul []
        [ List.map todoItem model.todos
        ]

addTodo : Model -> Html Msg
addTodo model =
    div []
        [ button [ onClick (AddTodo model.nextId) ] [ text "Add todo" ]
        ]

view : Model -> Html Msg
view model =
    div []
        [ todoList model
        , addTodo model
        ]
```

6) Add your new route(s) to `src/App/Route.elm`. Ex:

```elm
module App.Route exposing (Route(..), fromLocation, urlFor)

import Navigation
import UrlParser as Url exposing (s, top)

type Route
    = Home
+   | Todos

parser : Url.Parser (Route -> a) a
parser =
    Url.oneOf
        [ Url.map Home top
+       , Url.map Todos (s "todos")
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
                  
+               Todos ->
+                   "/todos"
    in
        "#" ++ url

```

7) Wire up the messages in `src/App/Msg.elm`. Ex:

```elm
import App.Route exposing (Route)
import Views.Home.Msg as Home
import Views.Todos.Msg as Todos -- Import your new messages.

type Msg
    = HomeMsg Home.Msg
+   | TodosMsg Todos.Msg
    | NavigateTo Route
    | UrlChange Navigation.Location
    | NoOp

```

8) Wire up the update function in `src/App/Update.elm`. Ex:

```elm
import App.Model exposing (Model)
import App.Msg exposing (Msg(..))
import App.Route
import Views.Home.Update as Home
import Views.Todos.Update as Todos -- Import your new module.

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg subMsg ->
            let
                (newModel, cmd) = Home.update subMsg model
            in
                (newModel, Cmd.map HomeMsg cmd)
        
+       TodosMsg subMsg ->
+           let
+               (newModel, cmd) = Todos.update subMsg model
+           in
+               (newModel, Cmd.map TodosMsg cmd)
        
        NavigateTo route ->
            let
                url = App.Route.urlFor route
            in
                (model, Navigation.newUrl url)
```

9) Wire up the view in `src/App/View.elm`. Ex:

```elm
import App.Model exposing (Model)
import App.Msg exposing (Msg(..))
import App.Route exposing (Route(..))
import Views.Home.View as Home
import Views.Todos.View as Todos -- Import your new view.

view : Model -> Html Msg
view model =
    viewForRoute model

viewForRoute : Model -> Html Msg
viewForRoute model =
    let
        route =
            case List.head model.history of
                Just route ->
                    route
                
                Nothing ->
                    Nothing
    in
        case route of
            Just Home ->
                Html.map HomeMsg (Home.view model)
            
+           Just Todos ->
+               Html.map TodosMsg (Todos.view model)
            
            Nothing ->
                text "404"
```

## License

This project uses the [UNLICENSE](http://unlicense.org/) license.
See the `UNLICENSE` file for more details.
