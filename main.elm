module Main exposing (..)

import Html exposing (Html, text, div, program)
import Mouse
import Svg exposing (..)
import Svg.Attributes exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { mouseX : Int
    , mouseY : Int
    , circles : List Circle
    }


type alias Circle =
    { x : Int
    , y : Int
    }


initialModel : Model
initialModel =
    { mouseX = 0
    , mouseY = 0
    , circles = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = Position Int Int
    | NewCircle Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Position x y ->
            ( { model | mouseX = x, mouseY = y }, Cmd.none )

        NewCircle x y ->
            ( { model | circles = Circle x y :: model.circles }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves (\{ x, y } -> NewCircle x y)



-- VIEW


renderAllCircles : Model -> Html Msg
renderAllCircles model =
    List.map renderCircle model.circles
        |> svg [ Svg.Attributes.width "100%", Svg.Attributes.height "100%" ]


renderCircle : Circle -> Html Msg
renderCircle shape =
    circle [ cx (toString shape.x), cy (toString shape.y), r "20", fill "blue" ] []


view : Model -> Html Msg
view model =
    renderAllCircles model
