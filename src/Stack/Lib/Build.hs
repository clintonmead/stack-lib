module Stack.Lib.Build (build, buildWithResolver, buildWithResolvers) where

import Stack.Types.Config (globalResolver)
import Stack.Types.Config.Build (defaultBuildOptsCLI)
import Stack.Lib.LowerLevel.Runners (defaultGlobalOpts)
import Stack.Lib.Class.IsAbstractResolver (IsAbstractResolver(toAbstractResolver))
import Stack.Lib.LowerLevel.Build (buildWithOptions)

import Control.Monad (mapM_)

buildWithResolver :: IsAbstractResolver resolver => resolver -> IO ()
buildWithResolver resolver = buildWithOptions defaultGlobalOpts{globalResolver = Just (toAbstractResolver resolver)} defaultBuildOptsCLI

buildWithResolvers :: (Foldable f, IsAbstractResolver resolver) => f resolver -> IO ()
buildWithResolvers = mapM_ buildWithResolver

build :: IO ()
build = buildWithOptions defaultGlobalOpts defaultBuildOptsCLI
