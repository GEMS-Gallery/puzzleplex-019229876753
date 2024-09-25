export const idlFactory = ({ IDL }) => {
  const Puzzle = IDL.Vec(IDL.Vec(IDL.Nat));
  return IDL.Service({
    'getPuzzle' : IDL.Func([], [Puzzle], ['query']),
    'isSolved' : IDL.Func([], [IDL.Bool], ['query']),
    'makeMove' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Bool], []),
    'newPuzzle' : IDL.Func([], [Puzzle], []),
  });
};
export const init = ({ IDL }) => { return []; };
