module Stack.Lib.LowerLevel.GlobalOpts (defaultGlobalOpts) where

import Control.Monad.Logger (LogLevel(LevelInfo))
import Stack.Types.Runner (ColorWhen(ColorNever))
import Stack.Types.Config (GlobalOpts(..), StackYamlLoc(SYLDefault))

defaultGlobalOpts :: GlobalOpts
defaultGlobalOpts = GlobalOpts {
  globalReExecVersion = Nothing,
  globalDockerEntrypoint = Nothing,
  globalLogLevel = LevelInfo,
  globalTimeInLog = True,
  globalConfigMonoid = mempty,
  globalResolver = Nothing,
  globalCompiler = Nothing,
  globalTerminal = False,
  globalColorWhen = ColorNever,
  globalTermWidth = Nothing,
  globalStackYaml = SYLDefault
}
