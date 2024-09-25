import Bool "mo:base/Bool";

import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Random "mo:base/Random";

actor PuzzleGame {
  // Define the puzzle type
  type Puzzle = [[Nat]];

  // Store the current puzzle state
  stable var currentPuzzle : [[var Nat]] = Array.tabulate(3, func(_ : Nat) : [var Nat] {
    Array.tabulateVar(3, func(_ : Nat) : Nat { 0 })
  });

  // Generate a new puzzle
  public func newPuzzle() : async Puzzle {
    let numbers = Array.tabulate<Nat>(9, func(i) = i);
    var shuffled = Array.thaw<Nat>(numbers);

    for (i in Iter.range(0, 8)) {
      let randomByte = await Random.blob();
      let j = Random.rangeFrom(9 - Nat8.fromNat(i), randomByte) + i;
      let temp = shuffled[i];
      shuffled[i] := shuffled[j];
      shuffled[j] := temp;
    };

    for (i in Iter.range(0, 2)) {
      for (j in Iter.range(0, 2)) {
        currentPuzzle[i][j] := shuffled[i * 3 + j];
      };
    };

    Array.map(currentPuzzle, func(row : [var Nat]) : [Nat] {
      Array.freeze(row)
    })
  };

  // Make a move
  public func makeMove(row : Nat, col : Nat) : async Bool {
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
    
    for ((dx, dy) in directions.vals()) {
      let newRow = Int.abs(row + dx);
      let newCol = Int.abs(col + dy);
      
      if (newRow < 3 and newCol < 3 and currentPuzzle[newRow][newCol] == 0) {
        let temp = currentPuzzle[row][col];
        currentPuzzle[row][col] := 0;
        currentPuzzle[newRow][newCol] := temp;
        return true;
      };
    };
    
    false
  };

  // Check if the puzzle is solved
  public query func isSolved() : async Bool {
    for (i in Iter.range(0, 2)) {
      for (j in Iter.range(0, 2)) {
        if (i == 2 and j == 2) {
          if (currentPuzzle[i][j] != 0) {
            return false;
          };
        } else if (currentPuzzle[i][j] != i * 3 + j + 1) {
          return false;
        };
      };
    };
    true
  };

  // Get the current puzzle state
  public query func getPuzzle() : async Puzzle {
    Array.map(currentPuzzle, func(row : [var Nat]) : [Nat] {
      Array.freeze(row)
    })
  };
}
