module Main where

import System.Environment
import PropDoc.Core
import PropDoc.Input.JavaProps

-- IO

main = do
  args <- getArgs
  name <- return (head args)
  contents <- readFile name
  let defs = props nameValuePair Nothing [] (lines contents)
  putStrLn $ foldr (\a acc -> acc ++ (show a)) "" defs