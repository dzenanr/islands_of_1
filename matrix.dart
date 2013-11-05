// Code based on http://www.geeksforgeeks.org/find-number-of-islands/ .

final bool VIEW_NEIGHBORS = false;

// Prepare a zero value visited matrix with the same size as a given matrix.
List<List<bool>> prepareVisitedMatrix(List<List<int>> matrix) {
  var height = matrix.length;
  var width = matrix[0].length;

  var visitedMatrix = new List<List<bool>>(height);
  for (var i = 0; i < height; i++) {
    visitedMatrix[i] = new List<bool>(width);
  }
  for (int row = 0; row < height; row++) {
    for (int col = 0; col < width; col++) {
      visitedMatrix[row][col] = false;
    }
  }
  return visitedMatrix;
}

// Check if a given cell (row, col) can be included in dfs.
bool safe(List<List<int>> matrix, int row, int col, List<List<bool>> visitedMatrix) {
  var height = matrix.length;
  var width = matrix[0].length;
  bool rowIsValid = row >= 0 && row < height;
  bool columnIsValid = col >= 0 && col < width;
  if (rowIsValid && columnIsValid) {
    bool valueIsOne = matrix[row][col] == 1;
    bool valueNotVisited = !visitedMatrix[row][col];
    if (valueIsOne && valueNotVisited) {
      return true;
    }
  }
  return  false;
}

// Depth First Search (DFS) for a 2D matrix.
// It only considers the 8 neighbors as adjacent cells.
void dfs(List<List<int>> matrix, int row, int col, List<List<bool>> visitedMatrix) {
  var height = matrix.length;
  var width = matrix[0].length;
  // Get row and column numbers of 8 neighbors of a given cell.
  List<int> nrowPositions = [-1, -1, -1,  0, 0,  1, 1, 1];
  List<int> ncolPositions = [-1,  0,  1, -1, 1, -1, 0, 1];

  // Cell is visited.
  visitedMatrix[row][col] = true;

  if (VIEW_NEIGHBORS) print('cell: ($row,$col)');
  // Iterate for all connected neighbours.
  for (int n = 0; n < 8; ++n) {
    var nrow = row + nrowPositions[n];
    var ncol = col + ncolPositions[n];
    if (VIEW_NEIGHBORS) print('neigbour: ($nrow,$ncol)');
    if (safe(matrix, nrow, ncol, visitedMatrix)) {
      dfs(matrix, nrow, ncol, visitedMatrix);
    }
  }
}

// Count number of islands (connected sets) in a given 2D matrix.
// For nice image of islands see:
// http://stackoverflow.com/questions/11232448/number-of-connected-sets
int countIslands(List<List<int>> matrix) {
  // Make a matrix to mark visited cells (1).
  // Initially all cells are unvisited (0).
  List<List<bool>> visitedMatrix = prepareVisitedMatrix(matrix);

  // Initialize count as 0 and travese through all the cells of the matrix.
  var height = matrix.length;
  var width = matrix[0].length;
  int count = 0;
  for (int row = 0; row < height; ++row)
    for (int col = 0; col < width; ++col)
      // If a cell with value 1 is not yet visited, then new island is found.
      if (matrix[row][col] == 1 && !visitedMatrix[row][col]) {
        dfs(matrix, row, col, visitedMatrix); // Visit all cells in this island
        ++count;                              // and increment island count.
      }
  return count;
}

display(List<List<int>> matrix) {
  print('matrix:');
  var height = matrix.length;
  var width = matrix[0].length;
  for (int row = 0; row < height; ++row)
    print(matrix[row]);
}

examine(List matrices) {
  print('Connected Sets -- Number of Islands of 1');
  for (var matrix in matrices) {
    print('');
    display(matrix);
    print('number of islands: ${countIslands(matrix)}');
  }
}

main() {
  List<List<int>> matrix0 =
      [[1, 0, 1, 1, 1, 0, 0, 0],
       [1, 0, 1, 1, 0, 0, 0, 1]];
  List<List<int>> matrix1 =
    [[1, 0, 0, 1],
     [0, 0, 1, 0],
     [0, 0, 1, 0],
     [1, 0, 0, 1]];
  List<List<int>> matrix2 =
    [[0, 0, 1, 0, 0, 1, 0, 0],
     [1, 0, 0, 0, 0, 0, 0, 1],
     [0, 0, 1, 0, 0, 1, 0, 1],
     [0, 1, 0, 0, 0, 1, 0, 0],
     [1, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 1, 1, 0, 1, 1, 0],
     [1, 0, 1, 1, 0, 1, 1, 0],
     [0, 0, 0, 0, 0, 0, 0, 0]];
  List<List<int>> matrix3 =
      [[1, 0, 0, 1],
       [0, 1, 1, 0],
       [0, 0, 1, 0],
       [1, 0, 1, 0],
       [1, 0, 1, 0],
       [1, 0, 0, 1]];
  var matrices = new List();
  matrices..add(matrix0)..add(matrix1)..add(matrix2)..add(matrix3);
  examine(matrices);
}