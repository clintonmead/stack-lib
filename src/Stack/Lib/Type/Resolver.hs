module Stack.Lib.Type.Resolver (
  Resolver(..)
  ) where

import Data.Ord (Ordering(LT, EQ, GT))
import Data.Time.Calendar (Day)

import qualified Stack.Types.Resolver as STR
import Stack.Lib.Class.IsAbstractResolver (IsAbstractResolver(toAbstractResolver))

data Resolver = LatestNightly | LatestLTS | LatestLTSMajor !Int | ExactLTS !Int !Int | ExactNightly !Day deriving Eq

instance Ord Resolver where
  LatestNightly `compare` LatestNightly = EQ
  LatestNightly `compare` _ = GT
  _ `compare` LatestNightly = LT
  ExactNightly day1 `compare` ExactNightly day2 = day1 `compare` day2
  ExactNightly{} `compare` _ = GT
  _ `compare` ExactNightly{} = LT
  LatestLTS `compare` LatestLTS = EQ
  LatestLTS `compare` _ = GT
  _ `compare` LatestLTS = LT
  LatestLTSMajor x1 `compare` LatestLTSMajor x2 = x1 `compare` x2
  ExactLTS x1 y1 `compare` ExactLTS x2 y2 = (x1, y1) `compare` (x2, y2)
  LatestLTSMajor x1 `compare` ExactLTS x2 _y2 = if x1 >= x2 then GT else LT
  ExactLTS x1 _y1 `compare` LatestLTSMajor x2 = if x1 > x2 then GT else LT

instance IsAbstractResolver Resolver where
  toAbstractResolver resolver = case resolver of
    LatestNightly -> STR.ARLatestNightly
    LatestLTS -> STR.ARLatestLTS
    LatestLTSMajor x -> STR.ARLatestLTSMajor x
    ExactLTS x y -> STR.ARResolver (STR.ResolverSnapshot (STR.LTS x y))
    ExactNightly date -> STR.ARResolver (STR.ResolverSnapshot (STR.Nightly date))
