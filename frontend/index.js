import { backend } from 'declarations/backend';

const puzzleGrid = document.getElementById('puzzle-grid');
const newGameButton = document.getElementById('new-game');
const statusElement = document.getElementById('status');

async function renderPuzzle() {
    const puzzle = await backend.getPuzzle();
    puzzleGrid.innerHTML = '';
    
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            const tile = document.createElement('div');
            tile.className = 'tile';
            tile.textContent = puzzle[i][j] || '';
            tile.addEventListener('click', () => makeMove(i, j));
            puzzleGrid.appendChild(tile);
        }
    }
    
    checkSolved();
}

async function makeMove(row, col) {
    const moved = await backend.makeMove(row, col);
    if (moved) {
        renderPuzzle();
    }
}

async function checkSolved() {
    const solved = await backend.isSolved();
    statusElement.textContent = solved ? 'Puzzle solved!' : 'Keep going!';
}

async function newGame() {
    await backend.newPuzzle();
    renderPuzzle();
}

newGameButton.addEventListener('click', newGame);

// Initial render
renderPuzzle();
