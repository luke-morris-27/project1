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
evalExpr (tok:rest) history
  | tok == "+" = evalOp (+) rest history
  | tok == "-" = evalOp (-) rest history
  | tok == "*" = evalOp (*) rest history
  | tok == "/" = evalOp (/) rest history
  | "$" 'prefixOf' tok = case parseHistory tok history of
    Just val -> Right (val, rest)
    Nothing -> Left "Invalid history reference"
  | other = case read tok :: Maybe Double of
    Just num -> Right (num, rest)
    Nothing -> Left "Invalid Token"

parseHistory :: String -> [Double] -> Maybe Double
parseHistory ('$':digits) history
  | all isDigit digits =
    let index = read digits - 1
    in if index >= 0 && index < length history
      then Just (history !! index)
      else Nothing
parseHistory _ = Nothing
 
