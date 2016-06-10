module LogRunnerExample exposing (..)

{-| HOW TO RUN THIS EXAMPLE

$ elm-make LogRunnerExample.elm --output=elm.js
$ node elm.js

Note that this always uses an initial seed of 42, since it can't do effects.
-}

import Assert
import Test exposing (..)
import Suite exposing (..)
import Test.Runner.Log


main : Program Never
main =
    Test.Runner.Log.run suites


suites : Suite
suites =
    Suite.batch [ oxfordifySuite ]


{-| stubbed function under Suite
-}
oxfordify : a -> b -> c -> String
oxfordify _ _ _ =
    "Alice, Bob, and Claire"


oxfordifySuite : Suite
oxfordifySuite =
    describe "oxfordify"
        Suite.batch
        [ describe "given an empty sentence"
            Suite.unit
            [ \_ ->
                it "returns an empty string"
                    <| Assert.equal
                        { expected = ""
                        , actual = oxfordify "This sentence is empty" "." []
                        }
            ]
        , describe "given a sentence with one item"
            Suite.unit
            [ \_ ->
                it "still contains one item"
                    <| Assert.equal
                        { expected = "This sentence contains one item."
                        , actual = oxfordify "This sentence contains " "." [ "one item" ]
                        }
            ]
        , describe "given a sentence with multiple items"
            Suite.unit
            [ \_ ->
                it "returns an oxford-style sentence"
                    <| Assert.equal
                        { expected = "This sentence contains one item and two item."
                        , actual = oxfordify "This sentence contains " "." [ "one item", "two item" ]
                        }
            , \_ ->
                it "returns an oxford-style sentence"
                    <| Assert.equal
                        { expected = "This sentence contains one item, two item, and three item."
                        , actual = oxfordify "This sentence contains " "." [ "one item", "two item", "three item" ]
                        }
            ]
        ]


{-| TODO get rid of this once elm-format puts <| on the same line
-}
describe : String -> (a -> Suite) -> a -> Suite
describe str fn arg =
    Suite.describe str (fn arg)
