import System.Environment (getArgs)
import Text.Read (readMaybe)
import Data.Char (isSpace, isDigit)

main :: IO ()
main = do
  args <- getArgs
  let interactive = case args of
    [] -> True
    ["-b"] -> False
    ["--batch"] -> False
    _ -> True
  runCalc interactive[]

-- Function to take user input

runCalc :: Bool -> [Double] -> IO ()
runCalc interactive history = do
  if interactive then putStr "> " else return ()
  line <- getLine
  if line == "quit"
    then return ()
    else do
      let tokens = words line
      case evalExpr tokens history of
        Left err -> putStrLn $ "Error: " ++ err
        Right (result, []) -> do
          let newID = length history + 1
          putStrLn $ show newID ++ ": " ++ show (realToFrac result :: Double)
          runCalc interactive (history ++ [result])
        Right (_, leftover) ->
          putStrLn "Error: Invalid Expression" >> runCalc interactive history

evalExpr :: [String] -> [Double] -> Either String (Double, [String])
evalExpr [] _ = Left "Invalid Expression"
 
