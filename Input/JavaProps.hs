module Input.JavaProps where

{-
  chris@thegodcode.net
-}

import Core

comment :: String -> Bool
comment [] = False
comment (x:_) = x == '#'

desc :: String -> String
desc = dropWhile (\x -> x == ' ') -- TODO wrong

-- Input a name/value parser, a previous last line, accumulated Defs, and an input list of lines.
-- TODO assumes a line + previous line = name/value plus description
props :: (Char -> String -> Maybe (String, String)) -> Maybe String -> [Def] -> [String] -> [Def]
props nvp ml ds ([]:xs) = props nvp ml ds xs -- ignore empty lines
props _ Nothing ds [] = reverse ds
props nvp Nothing ds (x:xs) = props nvp (Just x) ds xs
props nvp ml ds (x:xs) =
  case (nvp '=' x)
    of Just (n, _) -> props nvp Nothing ((Def n (fmap desc ml)) : ds) xs
       -- TODO propagate failure

