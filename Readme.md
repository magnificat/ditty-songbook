[![Travis – build status
](https://img.shields.io/travis/magnificat/magnificat.surge.sh/master.svg?style=flat-square
)](https://travis-ci.org/magnificat/magnificat.surge.sh
) [![Code style: airbnb
](https://img.shields.io/badge/code%20style-airbnb-777777.svg?style=flat-square
)](https://github.com/airbnb/javascript
)


# magnificat.surge.sh [➔](https://magnificat.surge.sh)

**An installable songbook web app**

This is an installable web app[\*](#installable-web-app) using Elm, [git.io/jss-lite](git.io/jss-lite) and service workers.

At the moment, it’s an experiment – I’m doing this to test out new technologies. The app will scratch my own itch, but I hope to create something sustainable along the way. Something useful for others.

<a id="installable-web-app">\* *installable web app* – there seems to be no agreement on how to name these things. Some call them [progressive web apps](https://developers.google.com/web/progressive-web-apps), some call them [native web apps](https://blog.andyet.com/2015/01/22/native-web-apps/) – and I remember seeing other names scattered over the internet. So, to follow the [well-established way of proliferating things](https://imgs.xkcd.com/comics/standards.png), I call them *installable* web apps. It’s accurate (in contrast to *native*), it’s understandable and explicit (in contrast to *progressive*) – and it implies that the app can run offline.


## TODO

* [x] Data parser (see [magnificat/ditty](https://github.com/magnificat/ditty))
* [x] Basic UI design
* [x] JS-module-based style system (see [git.io/jss-lite-loader](https://git.io/jss-lite-loader) and [git.io/jss-lite](https://git.io/jss-lite))
* [x] A rudimentary static layout
* [x] Static JSON API service (See [magnificat.surge.sh/api/categories.json](https://magnificat.surge.sh/api/categories.json),  [magnificat.surge.sh/api/songs.json](https://magnificat.surge.sh/api/songs.json) and the [`data/`](./data) directory)
* [x] CI integration with github data (The data and logic is updated after every push via [travis-ci.org/magnificat/magnificat.surge.sh](https://travis-ci.org/magnificat/magnificat.surge.sh))
* [ ] Navigation
* [ ] Full-screen lyrics display optimized for viewing on mobile devices and displaying with a projector
* [ ] Swipe navigation
* [ ] Offline installation
* [ ] “Add to home screen”
* [ ] Chords parser
* [ ] Opt-in chords display
* [ ] Lightning-fast font loading
* [ ] Server-side UI prerender


## License

[MIT](./License.md) © [Tomek Wiszniewski](https://github.com/tomekwi)
