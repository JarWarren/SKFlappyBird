# SpriteKit Flappy Bird

A SpriteKit rewrite of the world-famous Flappy Bird.

### Comments
* The project uses a "GameObject" protocol that allows SKScene to forward some of its callbacks to conforming children.
Ex. `SKScene.update()` calls `update()` on all of its children.

* While the gameplay works great, there's an occasional bug with audio. `SKAction.playSoundFileNamed(_:waitForCompletion:)` was designed for simple sound effects. Sadly in practice I got unreliable results. Apparently other developers have been encountering this issue for years. A real project might use SKAudioNode or AVPlayer.

* Lastly, I don't have every asset from the original game. So no pause buttton or fancy medals after a game over.

### Changes I would make for a bigger game
* In a larger project I might have made GameObject a word-for-word copy of all SKScene callbacks. Here, it only has 3 functions - `setUp()`, `update()` and `changeState(to:)`.

* Because this game really only takes place in one scene, I ended up using a GameState enum to keep track of which nodes are visible. I'm not a fan of the enum.
Each of the states in a real project (menu, playing, game over, settings, etc) would be their own SKScenes and instead of updating an enum case, I would be transitioning to a new SKScene altogether.
Breaking them into separate SKScenes would mean fewer nodes to keep track of and no "state" logic making sure the right things are hidden.

### Previews
<p float="left">
  <img src="PreviewImages/preview0.png" width="300" />
  <img src="PreviewImages/preview1.png" width="300" /> 
</p>

### Disclaimer
This application was written for educational purposes under Fair Use. I don't own Flappy Bird or any of its art and audio assets.
