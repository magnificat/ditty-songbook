const fs = require('fs');

const ditty = require('parse-ditty');
const pick = require('1-liners/pick');
const slugify = require('speakingurl');

const dataPath = `${__dirname}/../data`;
const rawCategories = fs.readdirSync(dataPath);
const categoryPattern = new RegExp(
  '^' +
    '(\\d+)' +    // (1) Category ID,
    '\\.\\s*' +   // followed by a dot and optional whitespace,
    '(.+)' +      // followed by (2) the category name.
  '$'
);
const categoriesData = rawCategories.map((dirname) => {
  const matches = dirname.match(categoryPattern);
  return {
    id: parseInt(matches[1], 10),
    name: matches[2],
  };
});

const categoryDirs = rawCategories.map((dirname, index) => ({
  id: categoriesData[index].id,
  dirname,
}));

const songsData = categoryDirs.reduce((result, category) => {
  const categoryPath = `${dataPath}/${category.dirname}`;
  const songFiles = fs.readdirSync(categoryPath);
  const parsedSongs = songFiles.map(filename => {
    const rawSong = fs.readFileSync(`${categoryPath}/${filename}`, 'utf8');
    const song = ditty(rawSong);
    return Object.assign({},
      pick(['number', 'title', 'blocks'], song),
      {
        category: category.id,
        slug: slugify(song.title),
      }
    );
  });
  return result.concat(parsedSongs);
}, []);

module.exports = {
  categories: JSON.stringify(categoriesData),
  songs: JSON.stringify(songsData),
};
