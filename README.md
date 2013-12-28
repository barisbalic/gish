# Gish

Github Issues on the command-line.  Not much else to say about it.

## Installation

  $ gem install gish

When you first use Gish you will be prompted for your github credentials, and asked if you would like to use Gish with private repositories.  This information is used to create a [personal access token](https://github.com/blog/1509-personal-api-tokens) for your Github account, this token will then be stored and used instead of your credentials.

You may also want to consider setting the environment variables `GISH_EDITOR` and `GISH_BROWSER`.  These will be used to launch an editor or browser respectively when the need arises.  When they are not set, Gish defaults to `EDITOR` and `BROWSER`, and finally `vi` and `open`.

Why 'open'? Because I'm an OSX user and there's no *nix analogue as far as I can tell.

## Usage
  
Gish has too many commands, subcommands and options to list here, thankfully it's uses the excellent [thor](http://whatisthor.com/) under the hood so you can use the help command like so to see your options...

```bash
  $ gish help
  $ gish subcommand help
```

Some commands may allow for excessive input, namely opening and commenting on issues.  In these cases, if you don't specify a message with "-m", Gish will spawn an editor for you to write the message in.

Oh, one more thing!  Gish expects you to be running against the repository under the origin remote, if you want to override this, use -r/--repository, like so:

```bash
  $ gish list -r andrew/24pullrequests
``` 

### Examples

Here are some examples to get you started.

|command|outcome|
|-------|-------|
|gish list | List 20 issues|
|gish show 1 | Show issue #1|
|gish show 1 -i| Show issue #1 and include comments|
|gish comment 1 -m ":+1"| Comment on issue #1|
|gish comment 1| Comment on issue #1 using an editor|
|gish close 1| Close issue #1|
|gish label 1 such-feature| Add the label such-feature to issue #1|

When listing issues, the number of comments on an issue will be displayed at the end of a line.

```
#9 barisbalic           Emoji!                                                                 [2]
#8 barisbalic           Fix editor input for open command                                      [0]
#7 barisbalic           Support API paging                                                     [0]
#6 barisbalic           Current repository check is lame                                       [1]
#5 barisbalic           Format issue and comment times                                         [0]
#4 barisbalic           Enhance terminal output                                                [0]
#2 barisbalic           Check issue assignee                                                   [0]
#1 barisbalic           Add config subcommand                                                  [0]
```



## Contributing

Contributions are very welcome, whether it's refactoring or taking care of the [issues](http://github.com/gish/issues).

1. Fork the repo.
2. create your branch `git checkout -b branch-name` **bonus for feature branches**
3. Make your changes
4. Test to make sure you have not broken any existing functionality
4. Commit your changes
5. Push to your branch
6. Submit a pull request

We will do our best to merge your PR or provide feedback as soon as possible!
