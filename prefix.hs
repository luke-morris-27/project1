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
