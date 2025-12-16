const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;
const REPO_PATH = path.join(__dirname, 'programdata'); // replace with your repo

// Function to recursively read folder structure
function readDirRecursive(dir) {
  const items = fs.readdirSync(dir, { withFileTypes: true });
  return items.map(item => {
    if (item.isDirectory()) {
      return { name: item.name, type: 'folder', children: readDirRecursive(path.join(dir, item.name)) };
    } else {
      return { name: item.name, type: 'file' };
    }
  });
}

// Serve the tree as JSON
app.get('/tree', (req, res) => {
  const tree = readDirRecursive(REPO_PATH);
  res.json(tree);
});

// Serve static HTML + JS
app.use(express.static('public'));

app.listen(PORT, () => console.log(`Server running on http://localhost:${9494}`));
