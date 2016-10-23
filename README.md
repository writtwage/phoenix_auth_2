# Basic Authentication with Elixir/Phoenix
Following this guide:  http://blog.simonstrom.xyz/elixir-phoenix-simple-authentication/.

The end result should be an app api that:
- creates users
- authenticates users
- validates that the user signed in with a valid token

Dependencies to be used:
- Mellon
- Joken
- Comeonin

# Current bug
Verify_token/1 called in validation_controller.ex, but is not defined in /web/models/user.ex. The guide does not appear to define it either.
