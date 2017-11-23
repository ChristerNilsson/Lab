import Html exposing (..)
import Html.Events exposing (..)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { dieFaces: (Int, Int)
  , history : List Int}

init : (Model, Cmd Msg)
init =
  (Model (1, 1) []
  , Cmd.none)

type Msg
  = Add2
  | Mul2
  | Div2
  | Next
  | Undo
  | NewFaces (Int, Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Add2 -> 
      ({model 
        | dieFaces = ((getDiceVal model 1)+2, getDiceVal model 2)
        , history =  (getDiceVal model 1) :: model.history
        }, Cmd.none)
    Mul2 -> 
      ({model 
        | dieFaces = ((getDiceVal model 1)*2, getDiceVal model 2)
        , history =  (getDiceVal model 1) :: model.history
        }, Cmd.none)
    Div2 -> 
      ({model 
        | dieFaces = (if (getDiceVal model 1) % 2 == 0 then (getDiceVal model 1) // 2 else (getDiceVal model 1), getDiceVal model 2)
        , history =  if (getDiceVal model 1) % 2 == 0 then (getDiceVal model 1) :: model.history else model.history
        }, Cmd.none)
    Next ->
      (model, Random.generate NewFaces diePairGenerator)
    Undo -> 
      ({model 
        | dieFaces = ((Maybe.withDefault (getDiceVal model 1) (List.head model.history)), (getDiceVal model 2)) 
        , history = Maybe.withDefault [] (List.tail model.history)
      }, Cmd.none)
    NewFaces newFaces ->
      (Model newFaces [], Cmd.none)

--subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString (getDiceVal model 1)) ]
    , h1 [] [ text (toString (getDiceVal model 2)) ]
    , button [ onClick Add2 ] [ text "+2"]
    , button [ onClick Mul2 ] [ text "*2"]
    , button [ onClick Div2 ] [ text "/2"]
    , button [ onClick Undo ] [ text "Undo"]
    , button [ onClick Next ] [ text "Next"]
    , h1 [] [ text (toString model.history) ]
    ]

--dieGenerator : Random.Generator Int
dieGenerator = Random.int 1 20

--diePairGenerator : Random.Generator (Int, Int)
diePairGenerator = Random.pair dieGenerator dieGenerator

getDiceVal : Model -> Int -> Int
getDiceVal model dieNumber =
  let
    (a, b) = model.dieFaces
  in
    case dieNumber of
      1 -> a
      2 -> b
      _ -> 0