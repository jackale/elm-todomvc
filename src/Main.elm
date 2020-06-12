module Main exposing (..)

import Browser
import Html exposing(..)
import Html.Attributes exposing (..)

type alias Flags = Int

main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    { inputTodo : String
    }


init : Flags -> (Model, Cmd Msg)
init _ =
    (Model "key", Cmd.none)

type Msg
    = Msg1
    | Msg2


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msg1 ->
            (model, Cmd.none)

        Msg2 ->
            (model, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Elm • TodoMVC"
    , body =
    [ section [ class "todoapp" ]
        [ header [ class "header" ]
            [ h1 []
                [ text "todos" ]
            , input [ attribute "autofocus" "", class "new-todo", placeholder "What needs to be done?" ]
                []
            ]
        , section [ class "main" ]
            [ input [ class "toggle-all", id "toggle-all", type_ "checkbox" ]
                []
            , label [ for "toggle-all" ]
                [ text "Mark all as complete" ]
            , ul [ class "todo-list" ]
                [ text "				"
                , li [ class "completed" ]
                    [ div [ class "view" ]
                        [ input [ attribute "checked" "", class "toggle", type_ "checkbox" ]
                            []
                        , label []
                            [ text "Taste JavaScript" ]
                        , button [ class "destroy" ]
                            []
                        ]
                    , input [ class "edit", value "Create a TodoMVC template" ]
                        []
                    ]
                , li []
                    [ div [ class "view" ]
                        [ input [ class "toggle", type_ "checkbox" ]
                            []
                        , label []
                            [ text "Buy a unicorn" ]
                        , button [ class "destroy" ]
                            []
                        ]
                    , input [ class "edit", value "Rule the web" ]
                        []
                    ]
                ]
            ]
        , footer [ class "footer" ]
            [ span [ class "todo-count" ]
                [ strong []
                    [ text "0" ]
                , text "item left"
                ]
            , ul [ class "filters" ]
                [ li []
                    [ a [ class "selected", href "#/" ]
                        [ text "All" ]
                    ]
                , li []
                    [ a [ href "#/active" ]
                        [ text "Active" ]
                    ]
                , li []
                    [ a [ href "#/completed" ]
                        [ text "Completed" ]
                    ]
                ]
            , button [ class "clear-completed" ]
                [ text "Clear completed" ]
            ]
        ]
    ]
    }
