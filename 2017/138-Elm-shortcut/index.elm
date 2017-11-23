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
  let (a, b) = model.dieFaces
  in
    case msg of
      Add2 -> 
          ({model 
            | dieFaces = (a+2, b)
            , history = a :: model.history
            }, Cmd.none)
      Mul2 -> 
          ({model 
            | dieFaces = (a*2, b)
            , history = a :: model.history
            }, Cmd.none)
      Div2 -> 
          ({model 
            | dieFaces = (if a % 2 == 0 then a // 2 else a, b)
            , history =  if a % 2 == 0 then a :: model.history else model.history
            }, Cmd.none)
      Next ->
        (model, Random.generate NewFaces diePairGenerator)
      Undo -> 
          ({model 
            | dieFaces = ((Maybe.withDefault a (List.head model.history)), b) 
            , history = Maybe.withDefault [] (List.tail model.history)
          }, Cmd.none)
      NewFaces newFaces ->
        (Model newFaces [], Cmd.none)

--subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

view : Model -> Html Msg
view model =
  let (a, b) = model.dieFaces
  in
    div []
      [ h1 [] [ text (toString a) ]
      , h1 [] [ text (toString b) ]
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
