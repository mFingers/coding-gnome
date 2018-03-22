import HangmanServer from './hangman_socket';

const RESPONSES = {
  won:          [ "success", "You Won!" ],
  lost:         [ "danger",  "You Lost!" ],
  good_guess:   [ "success", "Good guess!" ],
  bad_guess:    [ "warning", "Bad guess!" ],
  already_used: [ "info",    "You already guessed that" ],
  initializing: [ "info",    "Let's Play!" ]
}

function view(hangman) {
  const app = new Vue({
    el: "#app",
    data: { tally: hangman.tally },
    computed: {
      gameOver: function() {
        const state = this.tally.gameState;
        return (state === "won") || (state === "lost");
      },
      gameStateMessage: function() {
        const state = this.tally.gameState;
        return RESPONSES[state][1];
      },
      gameStateClass: function() {
        const state = this.tally.gameState;
        return RESPONSES[state][0];
      }
    },
    methods: {
      guess: function(ch) {
        hangman.makeMove(ch);
      },
      newGame: function() {
        hangman.newGame();
      },
      alreadyGuessed: function(ch) {
        return this.tally.used.indexOf(ch) >= 0;
      },
      correctGuess: function(ch) {
        return this.alreadyGuessed(ch) &&
          (this.tally.letters.indexOf(ch) >= 0);
      },
      turns_gt: function(left) {
        return this.tally.turnsLeft > left;
      },
    }
  })
}

window.onload = function() {
  let tally = {
    turnsLeft: 7,
    letters: ['a', '_', 'c'],
    gameState: 'initializing',
    used: [],
  };

  let hangman = new HangmanServer(tally);
  let app = view(hangman);

  hangman.connect();
};
