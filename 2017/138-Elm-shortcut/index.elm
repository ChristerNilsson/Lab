-- Synpunkter
-- Random komplext
-- Maybe komplext
-- Svårt ersätta tupeln med två variabler
-- Mycket kod
-- Dock, stabil känsla att kompilering => inga runtime errors

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
  { maze : (Int, Int)
  , history : List Int
  }

init : (Model, Cmd Msg)
init = (Model (1, 1) [], Cmd.none)

type Msg
  = Add2
  | Mul2
  | Div2
  | Next
  | Undo
  | NewMaze (Int, Int)

operation : Model -> Int -> Model
operation model value =
  let (a, b) = model.maze
  in
    {model 
      | maze = (value, b)
      , history = a :: model.history
    }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let (a, b) = model.maze
  in
    case msg of
      Add2 -> (operation model (a+2), Cmd.none)
      Mul2 -> (operation model (a*2), Cmd.none)
      Div2 -> 
        if a % 2 == 0 then
          (operation model (a//2), Cmd.none)
        else
          (model, Cmd.none)
      Next -> (model, Random.generate NewMaze diePairGenerator)
      Undo -> 
          ({model 
            | maze = ((Maybe.withDefault a (List.head model.history)), b) 
            , history = Maybe.withDefault [] (List.tail model.history)
          }, Cmd.none)
      NewMaze newMaze -> (Model newMaze [], Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

view : Model -> Html Msg
view model =
  let (a, b) = model.maze
  in
    div []
      [ myH1 a 
      , myH1 b
      , myButton Add2 "+2"
      , myButton Mul2 "*2"
      , myButton Div2 "/2"
      , myButton Undo "Undo"
      , myButton Next "Next"
      , myH1 model.history 
      ]

myH1 : a -> Html Msg
myH1 txt = h1 [] [ text (toString txt) ]

myButton : Msg -> String -> Html Msg
myButton msg txt = button [ onClick msg ] [ text txt]

dieGenerator : Random.Generator Int
dieGenerator = Random.int 1 20

diePairGenerator : Random.Generator (Int, Int)
diePairGenerator = Random.pair dieGenerator dieGenerator
