import System.Environment (getArgs)
import Chinese (toPairedChars, fromPairedChars)

argParse :: String -> String -> String
argParse arg = case arg of
    "--encode" -> (\y -> toPairedChars y)
    "-e" -> (\y -> toPairedChars y)
    "--decode" -> (\y -> fromPairedChars y)
    "-d" -> (\y -> fromPairedChars y)
    _ -> error "Invalid argument"

main = do
    args <- getArgs

    mapM_ (putStrLn . (argParse $ head args)) (tail args)
