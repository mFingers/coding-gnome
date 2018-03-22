import { Socket } from 'phoenix';

const handleError = (e) => {
  console.error(e);
};

export default class HangmanServer {
  constructor(tally) {
    this.tally = tally;

    this.socket = new Socket('/socket');
    this.socket.connect();
  }

  connect() {
    this.channel = this.socket.channel("hangman:game");
    this.channel.join()
      .receive("ok", (r) => {
        this.fetchTally();
      })
      .receive("error", handleError);

    this.channel.on("tally", t => {
      this.tally.turnsLeft = t.turns_left;
      this.tally.letters = t.letters;
      this.tally.gameState = t.game_state;
      this.tally.used = t.used;
    });
  }

  fetchTally() {
    this.channel.push("tally");
  }

  makeMove(guess) {
    this.channel.push("make_move", guess);
  }

  newGame() {
    this.channel.push("new_game");
  }
};
