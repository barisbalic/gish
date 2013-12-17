# Gish

Github Issues on the command-line.  Not much else to say about it.

## Installation

  $ gem install gish

When you first use Gish you will be prompted for your github credentials, and asked if you would like to use Gish with private repositories.  This information is used to create a [personal access token](https://github.com/blog/1509-personal-api-tokens) for your Github account, this token will then be stored and used instead of your credentials.

You may also want to consider setting the environment variables `GISH_EDITOR` and `GISH_BROWSER`.  These will be used to launch an editor or browser respectively when the need arises.  When they are not set, Gish defaults to `EDITOR` and `BROWSER`, and finally `vi` and `open`.

Why 'open'? Because I'm an OSX user and there's no *nix) analogue as far as I can tell.

## Usage
  
Gish has too many commands, subcommands and options to list here, thankfully it's uses the excellent [thor](http://whatisthor.com/) under the hood so you can use the help command like so to see your options...

  $ gish help
  
  $ gish subcommand help
  
Some commands may allow for excessive input, namely opening and commenting on issues.  In these cases, if you don't specify a message with "-m", Gish will spawn an editor for you to write the message in.

### Examples

Here are some examples to get you started.

|command|outcome|
|-------|-------|
|gish list | List the most recent 10 issues|
|gish list 50 | List the last 50 issues|
|gish show 1 | Show issue #1|
|gish show 1 -i| Show issue #1 and include comments|
|gish comment 1 -m ":+1"| Comment on issue #1|
|gish comment 1| Comment on issue #1 using an editor|
|gish close 1| Close issue #1|
|gish label 1 `such-feature`| Add the label `such-feature` to issue #1|

When listing issues, the number of comments on an issue will be displayed at the end of a line.  Noone has commented on these yet, so… well they are '0'.

```
#9 barisbalic           Emoji!                                                                 [0]
#8 barisbalic           Fix editor input for open command                                      [0]
#7 barisbalic           Support API paging                                                     [0]
#6 barisbalic           Current repository check is lame                                       [0]
#5 barisbalic           Format issue and comment times                                         [0]
#4 barisbalic           Enhance terminal output                                                [0]
#2 barisbalic           Check issue assignee                                                   [0]
#1 barisbalic           Add config subcommand                                                  [0]
```



## Contributing

Contributions are very welcome, take a look at issues for this project to see what I'd like to see added.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
