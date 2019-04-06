module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, br, div, h1, img, input, text)
import Html.Attributes exposing (class, placeholder, src, style, type_, value)
import Html.Events exposing (onInput)



---- MODEL ----


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" "" "", Cmd.none )



---- UPDATE ----


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Name name ->
            ( { model | name = name }, Cmd.none )

        Password password ->
            ( { model | password = password }, Cmd.none )

        PasswordAgain password ->
            ( { model | passwordAgain = password }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "section" ]
        [ h1 [] [ text "Elm Form" ]
        , img [ src "/logo.svg" ] []
        , br [] []
        , div [ class "columns is-mobile" ]
            [ div [ class "column is-half is-offset-one-quarter" ]
                [ div [ class "field" ]
                    [ div [ class "control" ]
                        [ viewInput "text" "Name" "input is-primary" model.name Name
                        ]
                    ]
                ]
            ]
        , div [ class "columns is-mobile" ]
            [ div [ class "column is-half is-offset-one-quarter" ]
                [ div [ class "field" ]
                    [ div [ class "control" ]
                        [ viewInput "password" "Password" "input is-info" model.password Password
                        ]
                    ]
                ]
            ]
        , div [ class "columns is-mobile" ]
            [ div [ class "column is-half is-offset-one-quarter" ]
                [ div [ class "field" ]
                    [ div [ class "control" ]
                        [ viewInput "password" "Re-enter Password" "input is-info" model.passwordAgain PasswordAgain
                        ]
                    ]
                ]
            ]
        , viewValidation model
        ]


viewInput : String -> String -> String -> String -> (String -> msg) -> Html msg
viewInput t p c v toMsg =
    input [ type_ t, placeholder p, class c, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "OK" ]

    else
        div [ style "color" "red" ] [ text "Passwords do not match!" ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
