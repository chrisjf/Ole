# Project Documentation

¡Olé! — Practice your Spanish!

Hi there!

Thanks for taking the time to review my coding challenge; the app is called "olé" which is Spanish for "bravo". I hope you enjoy it, and I am looking forward to meeting you in the technical interview, right? 😉

Cheers,

— Chris Forbes

## Requested Information

### How much time was invested:
- I worked on it here and there over 3 days.

### How was the time distributed (concept, model layer, view(s), game mechanics)
- I started off with a paper and pencil drawing out how I would make the architecture. 
- I settled on: a `TranslationsPaser` for the JSON file, a `WordPairManager` that holds all the words in memory, a `Scoreboard` for the user's current score, and a `GameplayController` to handle in-game actions. 
- Next, I worked on the views, etc. I think the time between milestones was split pretty evenly because of all the tests I wrote (har har) but I would say that I spent a little more time getting the architecture right, so that the rest of the pieces fell easily in to place for milestones 2 and 3.

### Decisions made to solve certain aspects of the game

- Why I chose not to include an `isCorrect` boolean value in the `WordPair` struct:
    - TL;DR: because of synonyms in Spanish.
    - If I had done this, there would be a bug where if there is the same Spanish translation for two separate English word entries, then the app would think the word pair is false, when it's not, and user wouldn't get the point.
    - E.g. "good morning" and "good day" are the same concept in Spanish, and translated as "buenos días".
    - I actually went ahead and tested this. Please see the test `testIsCorrectPairWithSpanishSynonyms` in `WordPairManagerTests`
    
- How I achieved the 25% probability:
	- I grabbed three random Spanish words, put them in an array with the correct Spanish translation. From this array (with 4 elements), I randomly pick the translation that will be used to show the user. Voilà! 25% probability. 
	- Please see the `newWordPair` method from `WordPairManager` for more details.

- The requirement "When the game ends, the app closes" doesn't make sense in an iOS context. 
	- An app cannot close itself on iOS. It can open another app (through URL schemes) but it can't close itself. 
	- I assumed that the requirement did not mean "the app should crash" when it stated "the app closes", as that doesn't make sense for a UX perspective.
	- Putting myself in the shoes of the user (A.K.A. thinking from a UX perspective), I interpreted "the app closes" as "the current game round closes", so I made a main menu screen `MenuView` and the app will "quit" to that screen. (The app still starts up with the game immediately starting, because that was a stated — and clear — requirement in milestone 1.)

### Decisions made because of restricted time

- No landscape mode. It wasn't specified in the instructions, and so probably not necessary for the MVP of a language learning app.
- No iPad/Mac support, just iPhone. Same as above.
- My testing makes use of mocks. For some tests I ran out of time and just used the real objects (e.g. I'm looking at you `GameplayViewTests`. 👀) I don't feel super bad about using real objects because the functionality is still tested. But yes for sure it means the tests are more coupled. (They depend on the implementation of the other objects which may change in future, thus potentially increasing the Software Maintenance costs.) In an ideal situation, I could also use a mocking library, such as OCMock which I've used before in a previous position (but I wasn't sure if 3rd party libraries were allowed during this challenge).
- You might notice that for views, the tests are pretty light. Instead of (or in addition to) unit testing SwiftUI views, I think it might be nice to have some Xcode UI tests, but this would be something to do given more time. 

### What would be the first thing to improve or add if there had been more time

- Dark mode!! (Obviously 😆)
- I think it would be interesting to increase the difficulty as the user gets more points:
    - The top 5000 words could be used (La Real Academia Española / The Royal Spanish Academy has a list [available here](http://corpus.rae.es/lfrecuencias.html)) to create more difficult options for wrong pairs. I.e. words that look similar to the correct answer could be used as the difficulty increases. E.g. for the correct pair "to operate"/"manejar", the incorrect pair "to operate"/"mantener" might be used instead because it's approximately the same length and begins and ends with the same letters.
    - The words.json file could be amended to include common "false friends" (incorrect pairings) for really high difficulty levels. E.g. "real" in Spanish does not mean "real" in English but "royal"!
- Could add sounds
- Could add "rumble-pack" style vibrations with the Taptic Engine to give more Pavlovian feedback to the user 🐶
- Make the app work in landscape mode
- Make the app work on iPad, Apple Watch, Mac
- It would be nice to add a background to the falling word; that way it's easier to read as it falls, and don't overlap with other on-screen elements (e.g. the English translation, or current score).
