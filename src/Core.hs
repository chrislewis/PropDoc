module Core where

type NVParser = Char -> String -> Maybe (String, String)

-- A named directive with an optional description.
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

-- TODO provided?
startsWith :: String -> String -> Bool
startsWith pfx s | length pfx <= length s = foldr (\a b -> b && fst a == snd a) True (zip pfx s)
startsWith _ _ = False

-- Parse a string into a 'name' and 'value' pair, given a value v and a delimiter d.
nvp :: Char -> String -> Maybe (String, String)
nvp d v = case (split d v) of
           (name:value:[]) -> Just (name, value)
           _ -> Nothing


str (Def name (Just value)) = "Name        : " ++ name ++ "\nDescription : " ++ value ++ "\n\n"
str (Def name _) = "Name        : " ++ name ++ "\nDescription : <Nothing>\n\n"


foobs show' = foldr (\a acc -> acc ++ (show' a)) ""