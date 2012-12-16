module Main (main) where

import PropDoc.Input.JavaProps
import Test.Framework (defaultMain)
import Test.Framework.Providers.QuickCheck2 (testProperty)

main :: IO ()
main = defaultMain
  [ testProperty "Property description" prop_isComment ]

prop_isComment :: String -> Bool
prop_isComment s @ ('#':_) = isComment s
prop_isComment s = not $ isComment s
