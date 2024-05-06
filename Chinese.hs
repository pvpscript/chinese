module Chinese where

import Data.Bits (shiftL, shiftR, (.|.), (.&.))
import Data.Char (ord, chr)

toPairedChars :: String -> [Char]
toPairedChars str =
    map chr $ strToPairedOctets str
    where
      strToPairedOctets :: String -> [Int]
      strToPairedOctets str =
          groupOctets $ map ord str
          where
            groupOctets :: [Int] -> [Int]
            groupOctets [] = []
            groupOctets [x] = [x `shiftL` 8]
            groupOctets (x:y:xs) =
              groupOctets' x y : groupOctets xs
              where
                groupOctets' :: Int -> Int -> Int
                groupOctets' left right = (left `shiftL` 8) .|. right

fromPairedChars :: [Char] -> String
fromPairedChars chars =
  pairsToString $ expandPairedOctet $ map ord chars 
  where
    pairsToString :: [[Int]] -> String
    pairsToString pairs =
      map chr $ concat pairs
    expandPairedOctet :: [Int] -> [[Int]]
    expandPairedOctet [] = []
    expandPairedOctet (x:xs) =
      expandPairedOctet' x : expandPairedOctet xs
      where
        expandPairedOctet' :: Int -> [Int]
        expandPairedOctet' x 
          | lastPair == 0 = [x `shiftR` 8 .&. 0xFF]
          | otherwise = [x `shiftR` 8 .&. 0xFF, lastPair]
          where
            lastPair = x .&. 0xFF
