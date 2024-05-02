module Chinese where

import Data.Bits (shiftL, shiftR, (.|.), (.&.))
import Data.Char (ord, chr)

toPairedChars :: String -> [Char]
toPairedChars str =
    map chr $ strToPairedOctets str

strToPairedOctets :: String -> [Int]
strToPairedOctets str =
    groupOctets $ map ord str

groupOctets :: [Int] -> [Int]
groupOctets [] = []
groupOctets [x] = [shiftL8 x]
groupOctets (x:y:xs) = groupOctets' x y : groupOctets xs

groupOctets' :: Int -> Int -> Int
groupOctets' left right = (shiftL8 left) .|. right

shiftL8 :: Int -> Int
shiftL8 val = val `shiftL` 8

-- 

fromPairedChars :: [Char] -> String
fromPairedChars chars =
   pairsToString $ expandPairedOctet $ map ord chars 

expandPairedOctet :: [Int] -> [[Int]]
expandPairedOctet [] = []
expandPairedOctet (x:xs) = expandPairedOctet' x : expandPairedOctet xs

expandPairedOctet' :: Int -> [Int]
expandPairedOctet' x 
    | lastPair == 0 = [x `shiftR` 8 .&. 0xFF]
    | otherwise = [x `shiftR` 8 .&. 0xFF, lastPair]
    where lastPair = x .&. 0xFF

pairsToString :: [[Int]] -> String
pairsToString pairs =
    map chr $ concat pairs
