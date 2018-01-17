module Stack.Lib.Snapshots (getSnapshots) where

import qualified Stack.Config

import Stack.Prelude (RIO)
import Stack.Types.Config (Config)

import Stack.Types.Resolver (Snapshots)
import Stack.Lib.LowerLevel.Runners (runStack)

getSnapshots :: IO Snapshots
getSnapshots = runStack (Stack.Config.getSnapshots :: RIO Config Snapshots)
