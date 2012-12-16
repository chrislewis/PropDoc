module Main where

import System.Environment
import PropDoc.Core
import PropDoc.Input.JavaProps

jp = props nvp Nothing []

-- IO

main = do
  args <- getArgs
  name <- return (head args)
  contents <- readFile name
  putStrLn $ foobs str (jp (lines contents))
  -- putStrLn (show (jp (lines contents)))