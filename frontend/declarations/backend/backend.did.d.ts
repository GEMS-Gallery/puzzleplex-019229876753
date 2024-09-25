import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export type Puzzle = Array<Array<bigint>>;
export interface _SERVICE {
  'getPuzzle' : ActorMethod<[], Puzzle>,
  'isSolved' : ActorMethod<[], boolean>,
  'makeMove' : ActorMethod<[bigint, bigint], boolean>,
  'newPuzzle' : ActorMethod<[], Puzzle>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
