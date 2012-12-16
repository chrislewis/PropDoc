module PropDoc.Input.JavaProps where

import PropDoc.Core
import Control.Monad (mfilter)
import Prelude hiding (foldr)
import Data.Foldable (foldr)
import Data.List (isPrefixOf)

-- Test if a line is a comment.
isComment = isPrefixOf "#"

-- Test if a line is a property setting.
isNVP = not . isComment

-- Extract a description from a comment string.
getPropDesc :: String -> String
getPropDesc = dropWhile (\x -> x == ' ' || x == '#')

{-
  Input a name/value parser, the previous line, accumulated Defs, and an input list of lines
  to yield a list of Defs.
-}
props :: NVParser -> Maybe String -> [Def] -> [String] -> [Def]
props ps ml ds ([]:xs) = props ps ml ds xs                                          -- ignore empty lines
props ps ml ds (x:xs) | isComment x = props ps (Just x) ds xs                       -- pull new comments through, discarding any previous
props ps ml ds (x:xs) =                                                             -- process property declarations immediately
  let def = (\(n, _) -> Def n (fmap getPropDesc ml)) `fmap` (ps '=' x)
      ds' = foldr (\a b -> a : b) ds def
  in props ps Nothing ds' xs
props ps ml ds [] = foldr (\l accDs ->                                              -- end of input; if we have a previous line that indicates a Def, parse and cons
  let def = (\(n, _) -> Def n (fmap getPropDesc ml)) `fmap` (ps '=' l)
  in foldr (\a b -> a : b) ds def) ds (mfilter isNVP ml)