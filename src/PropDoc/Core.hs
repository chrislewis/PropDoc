module PropDoc.Core where

-- A function type to break a string into a tuple by some character.
type NVParser = Char -> String -> Maybe (String, String)

-- A named directive with an optional description.
data Def = Def String (Maybe String) deriving (Eq)

instance Show Def where
  show (Def name (Just value))  = "Name        : " ++ name ++ "\nDescription : " ++ value ++ "\n\n"
  show (Def name _)             = "Name        : " ++ name ++ "\nDescription : <Nothing>\n\n"

-- Parse a string into a 'name' and 'value' pair, given a value v and a delimiter d.
nameValuePair :: NVParser
nameValuePair d v = case (split d v) of
           (name:value:[]) -> Just (name, value)
           _ -> Nothing

{-
  String utilities. These must be in a core library somewhere, and when I find where,
  I'll replace these.
-}

-- Split a string starting with an explicit current string and accumulated parts.
splitOn :: String -> [String] -> Char -> String -> [String]
splitOn cur acc _ "" =
  reverse $ if cur == "" then acc
            else reverse cur : acc
splitOn cur acc d (x:xs) =
  if x == d then splitOn "" (reverse cur : acc) d xs
  else splitOn (x:cur) acc d xs

-- Most common specialization of splitOn (empty state).
split :: Char -> String  -> [String]
split = splitOn "" []