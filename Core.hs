module Core where

{-
  chris@thegodcode.net
-}

-- Def is a named directive with an optional description.
data Def = Def String (Maybe String) deriving (Eq, Show)

--         delim   input     current    auccum
splitOn :: Char -> String -> String -> [String] -> [String]
splitOn _ "" cur acc =
  reverse $ if cur == "" then acc
            else reverse cur : acc
splitOn d (x:xs) cur acc =
  if x == d then splitOn d xs "" (reverse cur : acc)
  else splitOn d xs (x:cur) acc

split :: Char -> String  -> [String]
split d s = splitOn d s "" []

-- Parse a string into a 'name' and 'value' pair, given a value v and a delimiter d.
nvp :: Char -> String -> Maybe (String, String)
nvp d v = case (split d v) of
           (name:value:[]) -> Just (name, value)
           _ -> Nothing


str (Def name (Just value)) = "Name        : " ++ name ++ "\nDescription : " ++ value ++ "\n\n"


foobs show' = foldr (\a acc -> acc ++ (show' a)) ""