Name Game
========

This is a little iOS app I wrote for learning the names and faces of the nice
people that work at [WillowTree](http://willowtreeapps.com/). I was interviewing
for a job there and I wanted to impress the interviewer so I whipped this up
before the interview.

Swiping to the right will mark the employee as remembered and swiping to the left
means that name is not yet memorized. Remembered employees are removed from the pile
so when it resets only the non-remembered employees are shown.

## Installation

You will have to clone the repo with `--recursive` and open `NameGame.xcodeproj`
in Xcode and build and run it from there.

```
git clone --recursive git@github.com:n8armstrong/namegame.git
```

The recursive bit is important because I use a git submodule,
a [fork of JMImageCache](https://github.com/n8armstrong/JMImageCache) for caching
the images.

## Screenshot

<img src="./screens/demo.gif" width="350px" />

## Implementation

I wrote a class that I call `SwipeStackView` to manage the Tinder-like interface.
It uses the [Delegate and Data Source Pattern](https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/DelegatesandDataSources/DelegatesandDataSources.html) much
like `UITableView` to display the cards in the stack. There are 3 views on the stack
at any given time and each time a card is swiped away the `SwipeStackView` asks its
`dataSource` (which in this case is the `LearnViewController`) for the next view
which will end up being the bottom view in the stack. This way the cards are only
generated as they are needed in contrast to all at once.

In addition to managing the views in the stack, the `SwipeStackView` handles
the touch events and performs the animations using _UIKit Dynamics_ which are a
way to animate interfaces with realistic effects introduced in iOS 7.
