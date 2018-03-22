import { Socket } from 'phoenix';

const handleError = (e) => {
  console.error(e);
};

export default class HangmanSocket {
  constructor() {
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

    this.channel.on("tally", console.dir);
  }

  fetchTally() {
    this.channel.push("tally");
  }
};
