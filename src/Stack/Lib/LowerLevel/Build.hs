module Stack.Lib.LowerLevel.Build (buildWithOptions) where

import Stack.Prelude (RIO)
import Stack.Types.Config (EnvConfig)

import Stack.Types.Config (GlobalOpts)
import Stack.Types.Config.Build (BuildOptsCLI)
import Stack.Lib.LowerLevel.Runners
import qualified Stack.Build

buildWithOptions :: GlobalOpts -> BuildOptsCLI -> IO ()
buildWithOptions globalOpts buildOptsCLI =
  runStackWithGlobalOpts globalOpts ((Stack.Build.build (const (pure ())) Nothing buildOptsCLI) :: RIO EnvConfig ())
