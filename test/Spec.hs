import Prelude hiding (EQ)
import Data.Set as Set
import Data.Map.Strict as Map

import Language.AQL

main :: IO ()
main = do
  putStrLn "AQL test suite"
  -- print typesideDom
  -- print schemaOne
  -- print schemaTwo
  -- print mappingTwoToOne
  -- print instanceOne

--------------------------------------------------------------------------------

schemaOne :: (Eq var, Eq fk) => Schema var String String String fk String
schemaOne =
  Schema typesideDom (Set.singleton "A") Map.empty atts' Set.empty Set.empty (\en (EQ (lhs, rhs)) -> lhs == rhs)
  where
    atts' = Map.fromList [ ("A_att", ("A", "Dom")) ]

schemaTwo :: Eq var => Schema var String String String String String
schemaTwo =
  Schema typesideDom (Set.fromList ["A", "B"]) atts atts' Set.empty Set.empty (\en (EQ (lhs, rhs)) -> lhs == rhs)
  where
    atts  = Map.fromList [ ("f"    , ("A", "B"  )) ]
    atts' = Map.fromList [ ("A_att", ("A", "Dom"))
                         , ("B_att", ("B", "Dom"))
                         ]

--------------------------------------------------------------------------------

-- instanceOne = Instance schemaOne
--   (Map.insert "g1" "A" Map.empty) Map.empty Set.empty (\(EQ (lhs,rhs)) -> lhs == rhs)
--   $ Algebra schemaOne (Map.fromList [("A", Set.singleton "x")])
--     (Map.empty) (Map.fromList [("A_att", Map.fromList [("x",Sym "c42" [])])])
--     (\t -> "x") (\t -> Gen "g1") (\t -> Sym "c42" []) (\t -> Sym "c42" [])

--------------------------------------------------------------------------------

-- mappingTwoToOne = Mapping schemaTwo schemaOne
--   (Map.fromList [("B", "A"), ("A","A")])
--   (Map.fromList [("f", Var ())])
--   (Map.fromList [("A_att", Att "att" (Var ())), ("B_att", Att "att" (Var ()))])
