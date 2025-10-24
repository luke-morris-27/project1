import System.Environment (getArgs)
import Text.Read (readMaybe)
import Data.Char (isSpace, isDigit)
import Data.List (isPrefixOf)

main :: IO ()
main = do
    args <- getArgs
    let interactive =
          case args of
              [] -> True
              ["-b"] -> False
              ["--batch"] -> False
              _ -> True
    runCalc interactive []

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
        Left err -> do
          putStrLn ("Error: " ++ err)
          runCalc interactive history
        Right (result, []) -> do
          let newID = length history + 1
          if interactive
            then do
              putStrLn (show newID ++ ": " ++ show (realToFrac result :: Double))
            else do
              putStrLn (show (realToFrac result :: Double))
          runCalc interactive (history ++ [result])
        Right (_, leftover) ->
          putStrLn "Error: Invalid Expression" >> runCalc interactive history


-- Function to evaluate prefix expressions

evalExpr :: [String] -> [Double] -> Either String (Double, [String])
evalExpr [] _ = Left "Error: Invalid Expression"
evalExpr (tok:rest) history
  | tok == "+" = evalOp (+) rest history
  | tok == "-" = evalOp (-) rest history
  | tok == "*" = evalOp (*) rest history
  | tok == "/" = evalDiv (/) rest history
  | "$" `isPrefixOf` tok =
        case parseHistory tok history of
            Just val -> Right (val, rest)
            Nothing  -> Left "Error: Invalid History Reference"
  | otherwise =
        case readMaybe tok :: Maybe Double of
            Just num -> Right (num, rest)
            Nothing  -> Left "Error: Invalid Token"

-- Parse history references

parseHistory :: String -> [Double] -> Maybe Double
parseHistory ('$':digits) history
    | all isDigit digits =
        let index = (read digits :: Int) - 1
        in if index >= 0 && index < length history
            then Just (history !! index)
            else Nothing
    | otherwise = Nothing
parseHistory _ _ = Nothing

-- Evaluate operators +, -, *

evalOp :: (Double -> Double -> Double) -> [String] -> [Double]
  -> Either String (Double, [String])
evalOp f tokens history = do
  (a, rest1) <- evalExpr tokens history
  (b, rest2) <- evalExpr rest1 history
  Right (f a b, rest2)
  
-- Evaluate operation /, must be seperate function to account for division by 0
  
evalDiv :: (Double -> Double -> Double) -> [String] -> [Double]
            -> Either String (Double, [String])
evalDiv f tokens history = do
    (a, rest1) <- evalExpr tokens history
    (b, rest2) <- evalExpr rest1 history
    if b == 0
        then Left "Error: Division by zero"
        else Right (f a b, rest2)
