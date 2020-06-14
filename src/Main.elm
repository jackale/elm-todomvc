module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Json.Decode as Json


type alias Flags =
    Int


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Todo =
    { content : String
    , status : TodoStatus
    , id : Int
    }


type TodoStatus
    = Done
    | None


type alias Model =
    { inputText : String
    , todos : List Todo
    , uid : Int
    }



-- INIT


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( Model "" [] 1, Cmd.none )


type Msg
    = ChangeText String
    | KeyPress Int
    | Delete Int



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeText newText ->
            ( { model | inputText = newText }, Cmd.none )

        KeyPress keyCode ->
            case keyCode of
                13 ->
                    ( { model | inputText = "", todos = { content = model.inputText, status = None, id = model.uid + 1 } :: model.todos, uid = model.uid + 1 }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Delete id ->
            ( { model | todos = List.filter (\todo -> todo.id /= id) model.todos }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


onKeyPress : (Int -> Msg) -> Attribute Msg
onKeyPress tagger =
    Html.Events.on "keypress" (Json.map tagger Html.Events.keyCode)


viewEntry : Todo -> ( String, Html Msg )
viewEntry todo =
    ( String.fromInt todo.id
    , li []
        [ div [ class "view" ]
            [ input [ attribute "checked" "", class "toggle", type_ "checkbox" ]
                []
            , label []
                [ text todo.content ]
            , button [ class "destroy", onClick (Delete todo.id) ]
                []
            ]
        , input [ class "edit", value "Create a TodoMVC template" ]
            []
        ]
    )


view : Model -> Browser.Document Msg
view model =
    { title = "Elm • TodoMVC"
    , body =
        [ section [ class "todoapp" ]
            [ div [ class "debug" ] [ text (model.inputText ++ String.fromInt (List.length model.todos)) ]
            , header [ class "header" ]
                [ h1 []
                    [ text "todos" ]
                , input [ attribute "autofocus" "", class "new-todo", placeholder "What needs to be done?", value model.inputText, onInput ChangeText, onKeyPress KeyPress ]
                    []
                ]
            , section [ class "main" ]
                [ input [ class "toggle-all", id "toggle-all", type_ "checkbox" ]
                    []
                , label [ for "toggle-all" ]
                    [ text "Mark all as complete" ]
                , Keyed.node "ul"
                    [ class "todo-list" ]
                    (List.map viewEntry model.todos)

                --      li [ class "completed" ]
                --     [ div [ class "view" ]
                --         [ input [ attribute "checked" "", class "toggle", type_ "checkbox" ]
                --             []
                --         , label []
                --             [ text "Taste JavaScript" ]
                --         , button [ class "destroy" ]
                --             []
                --         ]
                --     , input [ class "edit", value "Create a TodoMVC template" ]
                --         []
                --     ]
                -- , li []
                --     [ div [ class "view" ]
                --         [ input [ class "toggle", type_ "checkbox" ]
                --             []
                --         , label []
                --             [ text "Buy a unicorn" ]
                --         , button [ class "destroy" ]
                --             []
                --         ]
                --     , input [ class "edit", value "Rule the web" ]
                --         []
                --     ]
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
