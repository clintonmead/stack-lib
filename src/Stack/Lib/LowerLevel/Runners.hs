module Stack.Lib.LowerLevel.Runners (
  runStack,
  runStackWithResolver,
  RunStack(runStackWithGlobalOpts),
  defaultGlobalOpts
  )
where

import Stack.Prelude (RIO, runRIO)
import Stack.Types.Config (EnvConfig, Config, GlobalOpts(globalResolver, globalCompiler), lcConfig, lcLoadBuildConfig)
import Stack.Runners (loadConfigWithOpts)
import Stack.Setup (setupEnv)

import Stack.Lib.Type.Resolver (Resolver)
import Stack.Lib.LowerLevel.GlobalOpts (defaultGlobalOpts)
import Stack.Lib.Class.IsAbstractResolver (toAbstractResolver)

class RunStack config where
  runStackWithGlobalOpts :: GlobalOpts -> RIO config a -> IO a

instance RunStack EnvConfig where
  runStackWithGlobalOpts globalOpts rio = loadConfigWithOpts globalOpts f where
    f loadConfig = do
      buildConfig <- lcLoadBuildConfig loadConfig (globalCompiler globalOpts)
      envConfig <- runRIO buildConfig (setupEnv Nothing)
      runRIO envConfig rio

instance RunStack Config where
  runStackWithGlobalOpts globalOpts rio = loadConfigWithOpts globalOpts f where
    f loadConfig = runRIO (lcConfig loadConfig) rio

runStackWithResolver :: RunStack config => Resolver -> RIO config a -> IO a
runStackWithResolver resolver = runStackWithGlobalOpts defaultGlobalOpts{globalResolver = Just (toAbstractResolver resolver)}

runStack :: RunStack config => RIO config a -> IO a
runStack = runStackWithGlobalOpts defaultGlobalOpts
