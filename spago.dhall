{-
Welcome to a Spago project!
You can edit this file as you like.

Need help? See the following resources:
- Spago documentation: https://github.com/purescript/spago
- Dhall language tour: https://docs.dhall-lang.org/tutorials/Language-Tour.html

When creating a new Spago project, you can use
`spago init --no-comments` or `spago init -C`
to generate this file without the comments in this block.
-}
{ name = "maglibs"
, dependencies =
  [ "aff"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "foreign"
  , "js-date"
  , "maybe"
  , "newtype"
  , "node-http"
  , "nullable"
  , "prelude"
  , "psci-support"
  , "react-basic-hooks"
  , "simple-json"
  , "transformers"
  , "typelevel-prelude"
  , "variant"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
