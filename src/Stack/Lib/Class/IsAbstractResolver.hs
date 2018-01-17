module Stack.Lib.Class.IsAbstractResolver (IsAbstractResolver(toAbstractResolver), AbstractResolver) where

import Stack.Types.Resolver (AbstractResolver)

class IsAbstractResolver t where
  toAbstractResolver :: t -> AbstractResolver
